board = Denko::Board.new
bus = Denko::I2C::Bus.new(board: board, index: 0)
oled = Denko::Display::SSD1306.new(bus: bus, rotate: true) # address: 0x3C is default

# Draw some text on the OLED's canvas (a Ruby memory buffer).
canvas = oled.canvas
canvas.text_cursor = [27,60]
canvas.print("Hello World!")

# Add some shapes to the canvas.
baseline = 40
canvas.rectangle(10, baseline, 30, -30)
canvas.circle(66, baseline - 15, 15)
canvas.triangle(87, baseline, 117, baseline, 102, baseline - 30)

# Send the canvas to the OLED's graphics RAM so it shows.
oled.draw
