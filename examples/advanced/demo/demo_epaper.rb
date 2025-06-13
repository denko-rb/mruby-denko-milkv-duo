# E-paper displaying a to do list.
board  = Denko::Board.new
spi    = Denko::SPI::BitBang.new board: board, pins: { mosi: 2, clock: 3 }
epaper = Denko::Display::IL0373.new bus: spi, pins: { select: 4, dc: 5, reset: 14, busy: 15 }

epaper.rotate
canvas = epaper.canvas
canvas.clear

left_margin = 8
baseline = 20
text_height = 8

canvas.font = :bmp_8x16
canvas.text_cursor = left_margin, baseline
canvas.text "To Do List"

todos = [
  { text: "Write documentation", progress: 0 },
  { text: "Fix -ve value rectangle bug", progress: 1 },
  { text: "Release version 0.15", progress: 0 },
  { text: "More tests", progress: 0 },
]

todos.sort_by { |h| h[:progress] }.each do |item|
  baseline += 12
  canvas.font = :bmp_6x8
  canvas.rectangle x: left_margin, y: baseline, w: text_height, h: -text_height
  canvas.text_cursor = (left_margin + text_height + 4), baseline
  canvas.text item[:text]

  if item[:progress] == 1
    # X in checkbox
    canvas.line x1: left_margin+2, y1: baseline-2, x2: left_margin+text_height-3, y2: baseline-text_height+3
    canvas.line x1: left_margin+2, y1: baseline-text_height+3, x2: left_margin+text_height-3, y2: baseline-2
    # Strikethrough
    canvas.line x1: left_margin+text_height+4, x2: canvas.text_cursor[0], y1: baseline-3, y2: baseline-3
  end
end

epaper.draw
