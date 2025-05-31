board = Denko::Board.new

# Show the board variant first.
puts
puts "Board variant is: #{board.variant}"

puts
puts "Configure pinmux with the `duo-pinmux` program. Current pinmux:"

# Print the map out nicely.
puts
map = board.map
map.each_pair do |key, val|
  puts "#{('GP' + key.to_s).ljust(4, " ")} => #{val.upcase}"
end

puts
