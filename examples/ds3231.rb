ADDRESS = 0x68

board = Denko::Board.new
i2c   = Denko::I2C::Bus.new(board: board, index: 0)
i2c.search

if i2c.found_devices.empty?
  puts "No I2C devices connected!"
  return
end

unless (i2c.found_devices.include? ADDRESS)
  puts "DS3231 real time clock not found!"
  return
end

puts "Using DS3231 RTC at address #{ADDRESS.to_s(16).upcase}"; puts
rtc = Denko::RTC::DS3231.new(bus: i2c, address: ADDRESS)

t = Time.now
puts "Setting RTC to match system time: #{t}"
rtc.time = t

5.times do
  puts "RTC time is: now #{rtc.time}"
  sleep 5
end
