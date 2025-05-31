board = Denko::Board.new
map = board.map

# Print the map out nicely
map.each_pair do |key, val|
  puts "#{key.to_s.rjust(2, " ")} => #{val}"
end
