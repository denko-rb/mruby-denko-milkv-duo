PIN   = 4
board = Denko::Board.new
ir    = Denko::PulseIO::IROutput.new(board: board, pin: PIN)

# NEC Raw-Data=0xF708FB04. LSBFIRST, so the binary for each hex digit below is backward.
code =  [ 9000, 4500,                                 # Start bit
          560, 560, 560, 560, 560, 1690, 560, 560,    # 0010 0x4 command
          560, 560, 560, 560, 560, 560, 560, 560,     # 0000 0x0 command
          560, 1690, 560, 1690, 560,560, 560, 1690,   # 1101 0xB command inverted
          560, 1690, 560, 1690, 560, 1690, 560, 1690, # 1111 0xF command inverted
          560, 560, 560, 560, 560, 560, 560, 1690,    # 0001 0x8 address
          560, 560, 560, 560, 560, 560, 560, 560,     # 0000 0x0 address
          560, 1690, 560, 1690, 560, 1690, 560, 560,  # 1110 0x7 address inverted
          560, 1690, 560, 1690, 560, 1690, 560, 1690, # 1111 0xF address inverted
          560]                                        # Stop bit

loop do
  ir.write(code)
  sleep 1
end
