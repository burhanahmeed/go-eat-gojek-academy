require 'matrix'

class Map
	def createMap(data)
		data = data
		int = 20
		arr1 = Array.new(int) { Array.new(int, '00')}
		i = 0
		while i < data.length
			arr1[rand(int)][rand(int)] = data[i]
			i += 1
		end				
		return result = [arr1, arr1.map { |e| e.join(' ') }]
	end

	def coordinates(dt)
		map = createMap(dt)
		puts map[1]		
		i = 0
		while i < dt.length
			puts "#{dt[i]} = #{Matrix[*map[0]].index(dt[i])}"
			i +=1
		end
	end
end

data = ['D1', 'D2', 'D3', 'D4', 'D5', 'S1', 'S2', 'S3', 'UU']
object = Map. new
# object.createMap
object.coordinates(data)