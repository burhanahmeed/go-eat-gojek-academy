require_relative 'Map'
require_relative 'InitializeData'
require_relative 'DistanceCalculator'
require 'json'

class Index
	$history = []
	# rating driver
	$d1 = []
	$d2 = []
	$d3 = []
	$d4 = []
	$d5 = []

	def init
		puts
		puts "  ========================="
		puts "  ===                   ==="
		puts "  === Welcome to GO-EAT ==="		
		puts "  ===                   ==="
		puts "  ========================="
		puts		
		puts "=========LOAD MAP========"
		puts 
		mapData = Map.init()
		puts
		puts "D = driver, U = user, S = Store"		
		puts
		puts "There are several options for you:"
		puts "1. order food"
		puts "2. history"
		puts "3. driver rating"

		puts
		puts		
		print "Please input your option here: "
		input = gets.chomp
		puts

		if input == '1'
		    puts "Ordering food"
		    puts "1. Store 1 (S1)"
		    puts "2. Store 2 (S2)"
		    puts "3. Store 3 (S3)"
		    puts
		    puts

		    # pilih makanan yang ingin dibeli
		    print "Select a store bou want to buy food : "
		    input = gets.chomp
		    if input == '1'
		    	daftar = InitializeData.store1()
		    elsif input == '2'
		    	daftar = InitializeData.store2()
		    elsif input == '3'
		    	daftar = InitializeData.store3()
		    else
		    	init()
		    end

		    puts
		    puts daftar.map.with_index { |e, idx| "#{idx}. #{e['nama']}, Harga: #{e['harga']}" }
		    print "Choose ur menu (separate w/ comma): "
		    input = gets.chomp
		    puts
		    input = input.gsub(/\s+/, "") #menghapus whitespace
		    inputArray = input.split(',')
		    harga = 0
		    inputArray.map { |e| harga += daftar[e.to_i]['harga'].to_i }
		    puts "Harga makanan = #{harga}"

		    #mencari driver terdekat
		    drivers = [JSON.parse(mapData['D1']), JSON.parse(mapData['D2']), JSON.parse(mapData['D3']), JSON.parse(mapData['D4']), JSON.parse(mapData['D5'])]
		    min_num = 9999999999
		    indexs = 0
			drivers.map.with_index do |e, idx|
				jarak = DistanceCalculator.new(JSON.parse(mapData['UU']), e).distance
				if jarak < min_num
					indexs = idx
					min_num = jarak
				end
				# puts e
			end

			deliverBy = "D#{indexs+1}"
			driverPosition = mapData[deliverBy]
			puts 
			puts "=================================="
			puts "Your order will be delivered by D#{indexs+1}"
			puts "=================================="
			puts 
		    # puts min_num

		    # mencari jarak dari toko ke pelanggan
		    ongkir = DistanceCalculator.new(JSON.parse(mapData['UU']), JSON.parse(mapData[daftar[0]['toko']])).cost

		    puts "Biaya ongkir = #{ongkir.to_i}"
		    puts "Total biaya = #{ongkir.to_i + harga}"

		    nama = ''
		    inputArray.map.with_index { |e, idx| nama << "#{idx+1} #{daftar[e.to_i]['nama']} " }

		    $history << "Makanan: #{nama} | Total Bayar: #{ongkir.to_i + harga}"
		    puts
		    
		    # menghitung rute
		    puts "====== DRIVER'S ROUTE======="
		    puts "driver is on the way to store, start at #{driverPosition}"
		    driver_to_store = DistanceCalculator.new(JSON.parse(driverPosition), JSON.parse(mapData[daftar[0]['toko']])).route
		    driver_to_store['x'].map.with_index do |e, idx|
		    	print "go to #{e}"
		    	puts
		    end
		    driver_to_store['y'].map.with_index do |e, idx|
		    	print "go to #{e}"
		    	puts
		    end
		    puts "go to #{mapData[daftar[0]['toko']]}, driver arrived at the store!"
		    puts "driver has bought the item(s), start at #{mapData[daftar[0]['toko']]}"

		    # DRIVER KE PENGGUNA
		    driver_to_user = DistanceCalculator.new(JSON.parse(mapData[daftar[0]['toko']]), JSON.parse(mapData['UU'])).route
		    driver_to_user['x'].map.with_index do |e, idx|
		    	print "go to #{e}"
		    	puts
		    end
		    driver_to_user['y'].map.with_index do |e, idx|
		    	print "go to #{e}"
		    	puts
		    end
		    puts "go to #{mapData['UU']}, driver arrived at your place!"

		    puts
		    puts "THANK YOU FOR USING OUR GO-EAT APP"

		    puts
		    print "Giver our driver rating (1 - 5): "
		    rate = gets.chomp
		    rate = rate.to_i
		    if rate > 5
		    	rate = 5
		    end

		    # rate dirver
		    case deliverBy
			when 'D1'
				$d1 << rate
			when 'D2'
				$d2 << rate
			when 'D3'
				$d3 << rate
			when 'D4'
				$d4 << rate
			when 'D5'
				$d5 << rate
			end

		    puts
		    print "Press 1 to exit, press any to back to menu : "
		    input = gets.chomp
		    if input == '1'
		    	
		    else
		    	init()
		    end


		elsif input == '2' 
		    puts "========= See history ==========="
		    puts $history.map.with_index { |e, idx| "Pesanan ke #{idx+1}. #{e}" }
		    puts
		    print "Press 1 to exit, press any to back to menu : "
		    input = gets.chomp
		    if input == '1'
		    	
		    else
		    	init()
		    end
		elsif input == '3'
			puts "Rating Driver"
			puts "D1 = #{$d1.inject(0.0) { |sum, el| sum + el } / $d1.size}"
			puts "D2 = #{$d2.inject(0.0) { |sum, el| sum + el } / $d2.size}"
			puts "D3 = #{$d3.inject(0.0) { |sum, el| sum + el } / $d3.size}"
			puts "D4 = #{$d4.inject(0.0) { |sum, el| sum + el } / $d4.size}"
			puts "D5 = #{$d5.inject(0.0) { |sum, el| sum + el } / $d5.size}"
			puts
			print "Press 1 to exit, press any to back to menu : "
		    input = gets.chomp
		    if input == '1'
		    	
		    else
		    	init()
		    end
		else
		    init()
		end	
	end
end

puts ARGV

index = Index. new
index.init