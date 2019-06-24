puts "Welcome to Go-Eat"
puts
puts "There are several options for you:"
puts "1. order food"
puts "2. history"

print "Please input your option here: "
input = gets.chomp

if input == '1'
    puts "Ordering food"
elsif input == '2' 
    puts "See history"
else
    puts "Noting"
end


def makeMap
	arr1 = Array.new(3) { Array.new(3)}
end