require "dry/cli"


module Imagecrypt
	module CLI
		module Commands
			extend Dry::CLI::Registry
			
			
			class Encrypt < Dry::CLI::Command
				desc "Encrypt message in image"
				
                argument :message_arg, required: true, desc: "Message to encrypt"
				argument :path_arg, required: true, desc: "Image path"
				
                def call(message_arg:, path_arg: nil, **)
                    require_relative 'rice_wrap'
                    char_list = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","R","S","T","U","V","W","X","Y","Z","."," ","1","2","3","4","5","6","7","8","9","0", nil]
                    
					# Converts integer to a 3-size hexadecimal array
                    def binary_find(a)
                        digit_mem = []
                        digit_mem[0] = (a/16).floor
                        a -= digit_mem[0]*16
                        digit_mem[1] = (a/4).floor
                        a -= digit_mem[1]*4
                        digit_mem[2] = a
                        return digit_mem
                    end

                    def binary_return(a)
                        return a[0]*16+a[1]*4+a[2]
                    end

                    if message_arg.nil?
                        raise "ERROR, empty message"
                    end
                    if path_arg.nil?
                        raise "ERROR, empty path"
                    end
                    message = message_arg
                    path = path_arg
                    run = 0
                    digit_mem = []
                    store = 0
                    pix = 0
                    char_val = []

                    # Load image
                    image = ImageManager.new
                    image.loadImage(path)
                    tid = Time.now
                    while run < message.length
						# Find the character from the index and store the index in "store"
                        for x in 0..63
                            if char_list[x] == message[run]
                                store = x
                                break
                            end
                        end
						
                        binary_mem = binary_find(store)
                        for bite in 0..2
                            color = image.importPixel(pix)[0]
                            color_4 = color%4
                            color_code = binary_mem[pix%3]
                            color = color - color_4 + color_code
                            if color > 255
                                color -= 4
                            end
                            col_return = [color, image.importPixel(pix)[1], image.importPixel(pix)[2]]
                            image.exportPixel(pix, col_return)
                            pix += 1
                        end
                        run += 1
                    end
                    for x in 0..2
                        color = image.importPixel(pix+x)[0]
                        color = color - ( 3 - color%4)
                        col_return = [color, image.importPixel(run+x)[1], image.importPixel(run+x)[2]]
                        image.exportPixel(pix+x, col_return)
                    end
                    puts "tiden det tog sen per tecken"
                    p "meddelandes längd #{message.length}"
                    p [Time.now-tid, (Time.now-tid)/message.length]

                end
			end
			
			class Decrypt < Dry::CLI::Command
				desc "Decrypt message in image"
				
				argument :path_arg, required: true, desc: "Image path"

                def call(path_arg: nil, **)
                    # Execute here
				    require_relative 'rice_wrap'

                    if path_arg.nil?
                        raise "ERROR, empty path"
                    end
                    image = ImageManager.new
                    image.loadImage(path_arg)
                    message = ""
                    runs = 0
                    colors = []
                    char_val = []
                    char_list = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","R","S","T","U","V","W","X","Y","Z","."," ","1","2","3","4","5","6","7","8","9","0", nil]
                    while true
                        for n in 0..2
                            colors[n] = image.importPixel(n + 3*runs)[0]
                        end
                        for x in 0..2
                            char_val[x] = colors[x]%4
                        end
                        character = char_val[0]*16+char_val[1]*4+char_val[2] 
                        if character == 63
                            puts message
                            return message
                        end
                        message = message + char_list[character]
                        runs += 1
                    end
                    
                end
				
			end
			
			# Register commands
			register "encrypt", Encrypt
			register "decrypt", Decrypt
		end
	end
end

Dry::CLI.new(Imagecrypt::CLI::Commands).call