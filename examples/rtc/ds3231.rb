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

puts "Using DS3231 RTC at address Ox#{ADDRESS.to_s(16).upcase}";
rtc = Denko::RTC::DS3231.new(bus: i2c, address: ADDRESS)

# Get time from RTC and make it into a string Linux can parse.
t = rtc.time
time_string = t.year.to_s.rjust(4, "0") + "-" +
              t.month.to_s.rjust(2, "0") + "-" +
              t.day.to_s.rjust(2, "0") + " " +
              t.hour.to_s.rjust(2, "0") + ":" +
              t.min.to_s.rjust(2, "0") + ":" +
              t.sec.to_s.rjust(2, "0")

# Set the sytem time.
`date -s \"#{time_string}\"`
puts "Set sytem time to match RTC: #{time_string}"
