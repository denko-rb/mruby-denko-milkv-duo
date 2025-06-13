# OLED displaying date, time, enviro sensor and distance sensor readings.
board = Denko::Board.new

led   = Denko::LED.new(board: board, pin: 25)

i2c0  = Denko::I2C::Bus.new(board: board)
oled  = Denko::Display::SH1106.new(bus: i2c0)
oled.rotate
canvas = oled.canvas

i2c1  = Denko::I2C::Bus.new(board: board, index: 1)
bme   = Denko::Sensor::BME280.new(bus: i2c1)
rtc   = Denko::RTC::DS3231.new(bus: i2c1)
vl53  = Denko::Sensor::VL53L0X.new(bus: i2c1)
vl53.correction_offset = -52
vl53.smoothing = true
vl53.smoothing_size = 2

# Loop management
target_frame_time = 0.05
frame_start       = Time.now
last_bme_read     = Time.now - 6

loop do
  oled.draw

  frame_start  = Time.now
  canvas.clear

  # Date and time
  t = rtc.time
  date = t.year.to_s.rjust(4, "0") + "-" +
         t.month.to_s.rjust(2, "0") + "-" +
         t.day.to_s.rjust(2, "0")
  time = t.hour.to_s.rjust(2, "0") + ":" +
         t.min.to_s.rjust(2, "0") + ":" +
         t.sec.to_s.rjust(2, "0")
  canvas.text_cursor = 0,10
  canvas.text "Date: #{date}"
  canvas.text_cursor = 0,20
  canvas.text "Time: #{time}"

  # Only read BME280 every 5 seconds
  if (frame_start - last_bme_read  > 5)
    last_bme_read = frame_start
    bme.read
  end
  # But print the latest readings always
  canvas.text_cursor = 0,30
  canvas.text "Temp: #{bme.temperature.round(2).to_s.ljust(5, '0')} C"
  canvas.text_cursor = 0,40
  canvas.text "RH  : #{(bme.humidity).round(2).to_s.ljust(5,'0')} %"
  canvas.text_cursor = 0,50
  canvas.text "Pres: #{(bme.pressure_atm).round(5).to_s.ljust(7, '0')} atm"

  # Instead of sleeping before next frame, read the distance sensor a lot.
  # Treat it like a proximity sensor to toggle the LED.
  while (Time.now - frame_start < target_frame_time)
    vl53.read
    if (vl53.state && vl53.state < 150)
      canvas.text_cursor = 0,60
      canvas.text "Prox: YES"
      led.on
    else
      canvas.text_cursor = 0,60
      canvas.text "Prox: NO"
      led.off
    end
    sleep 0.002
  end
end
