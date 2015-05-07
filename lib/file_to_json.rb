def read_file(file_path)
	c = 0
	key_array = []
	val_array = []
	File.foreach(file_path) {|x|
		if c > 3
			split_line = line_strip(x)
			key_array.push(split_line[1])
			val_array.push(split_line[3])
		end
		c=c+1
	}
	create_hash(key_array, val_array)
end

def line_strip(line)
	split_line = line.split('"')
	#line_to_json(split_line)
	return split_line
end

def create_hash(keys, values)
	json_hash = Hash.new
	curr_key = keys[0]
	val_list = []
	for i in 0..keys.size
		if keys[i] == curr_key
			val_list.push(values[i])
		else
			json_hash[curr_key] = val_list
			curr_key = keys[i]
			new_list = []
			val_list = new_list
			val_list.push(values[i])
		end
	end
	
	hash_to_json(json_hash)
	
end

#split_line_array will be the array produced when line is split in line_strip
def hash_to_json(json_hash)
	json_hash.each do |key, array|
		print key
		print ": "
		print array
		puts
	end
end

read_file("../examples/ithaca/ithaca_20connections_5nested.dot")