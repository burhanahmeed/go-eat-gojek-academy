class DistanceCalculator
	def initialize(x, y)
		@point_x = x
		@point_y = y
	end
	# def coord_difference
	#     @coord_difference ||= @point_x.zip(@point_y).map { |x, y| y - x }
	# end

	# def distance
	# 	Math.sqrt(coord_difference.first ** 2 + coord_difference.last ** 2)
	# end
	def distance(pt1, pt2)  #menggunakan manhattan distance
	  (pt1[0]-pt2[0]).abs + (pt1[1]-pt2[1]).abs
	end

	def cost
	  return 300 * distance(@point_x, @point_y)  
	end
end

# points = {
#   'D1' => [24,2],
#   B: [32,42],
#   C: [3,11],
#   D: [5,9],
#   E: [10,5],
#   F: [14,2]
# }

# # example usage
# puts DistanceCalculator.new(points['D1'], points[:B]).cost