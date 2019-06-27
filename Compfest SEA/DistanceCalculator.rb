class DistanceCalculator
	def initialize(x, y)
		@point_x = x
		@point_y = y
	end
	def different(pt1, pt2)  #menggunakan manhattan distance
	  (pt1[0]-pt2[0]).abs + (pt1[1]-pt2[1]).abs
	end
	def distance
		different(@point_x, @point_y)
	end
	def cost
	  return 300 * different(@point_x, @point_y)
	end
	def route		
		# print @point_x
		# print @point_y		
		x1 = @point_x[0]
		y1 = @point_x[1]
		x2 = @point_y[0]
		y2 = @point_y[1]
		pointX = []
		pointY = []
		if x1 > x2
			while x1 > x2 
				pointX << [x1, y1]
				x1 -=1
			end
			if y1 > y2
				while y1 > y2 
					pointY << [x1, y1]
					y1 -= 1
				end
			else
				while y1 < y2 
					pointY << [x1, y1]
					y1 += 1
				end
			end
		else
			while x1 < x2 
				pointX << [x1, y1]
				x1 +=1
			end
			if y1 > y2
				while y1 > y2 
					pointY << [x1, y1]
					y1 -= 1
				end
			else
				while y1 < y2 
					pointY << [x1, y1]
					y1 += 1
				end
			end
		end
		# print "Arah samping #{pointX}"
		# puts
		# print "Arah bawah #{pointY}"
		route = {
			'x' => pointX,
			'y' => pointY
		}
		return route		
	end
end

# points = {
#   'D1' => [5,9],
#   B: [1,5],
#   C: [3,11],
#   D: [5,9],
#   E: [10,5],
#   F: [14,2]
# }

# # # example usage
# puts DistanceCalculator.new(points['D1'], points[:B]).route