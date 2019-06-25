require_relative 'Map'
require_relative 'InitializeData'
require_relative 'DistanceCalculator'
require 'json'

class Index
	$history = []
	def init
		puts
		puts "  ========================="
		puts "  ===                   ==="
		puts "  === Welcome to GO-EAT ==="		
		puts "  ===  This is Our Map  ==="
		puts "  ===                   ==="
		puts "  ========================="
		puts		
		puts "             LOAD MAP"
		puts 
		mapData = Map.init()
		puts
		puts "D = driver, U = user, S = Store"		
		puts
		puts "There are several options for you:"
		puts "1. order food"
		puts "2. history"

		print "Please input your option here: "
		input = gets.chomp

		if input == '1'
		    puts "Ordering food"
		    puts "1. Store 1 (S1)"
		    puts "2. Store 2 (S2)"
		    puts "3. Store 3 (S3)"
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

		    puts daftar.map.with_index { |e, idx| "#{idx}. #{e['nama']}, Harga: #{e['harga']}" }
		    print "Choose ur menu (separate w/ comma): "
		    input = gets.chomp
		    puts
		    input = input.gsub(/\s+/, "") #menghapus whitespace
		    inputArray = input.split(',')
		    harga = 0
		    inputArray.map { |e| harga += daftar[e.to_i]['harga'].to_i }
		    puts "Harga makanan = #{harga}"
		    ongkir = DistanceCalculator.new(JSON.parse(mapData['UU']), JSON.parse(mapData[daftar[0]['toko']])).cost
		    puts "Biaya ongkir = #{ongkir.to_i}"
		    puts "Total biaya = #{ongkir.to_i + harga}"

		    nama = ''
		    inputArray.map.with_index { |e, idx| nama << "#{idx+1} #{daftar[e.to_i]['nama']} " }

		    $history << "Makanan: #{nama} | Total Bayar: #{ongkir.to_i + harga}"
		    puts
		    puts "TERIMA KASIH TELAH MENGGUNAKAN GO-EAT"
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

		else
		    init()
		end	
	end
end

index = Index. new
index.init