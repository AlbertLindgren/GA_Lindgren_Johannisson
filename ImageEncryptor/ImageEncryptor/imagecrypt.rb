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
                    # Execute here
                    #require_relative 'dekryptering'
                    require_relative 'rice_wrap'
                    char_list = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",".",","," ","?","!", nil]
                    
                    def binary_find(a)
                        digit_mem = []
                        if a-16>=0
                            digit_mem[0] = 1
                            a-=16
                        else
                            digit_mem[0] = 0
                        end
                    
                        if a-8>=0
                            digit_mem[1] = 1
                            a-=8
                        else
                            digit_mem[1] = 0
                        end
                        
                        if a-4>=0
                            digit_mem[2] = 1
                            a-=4
                        else
                            digit_mem[2] = 0
                        end
                        
                        if a-2>=0
                            digit_mem[3] = 1
                            a-=2
                        else
                            digit_mem[3] = 0
                        end
                        
                        if a-1>=0
                            digit_mem[4] = 1
                        else
                            digit_mem[4] = 0
                        end
                        return digit_mem
                    end

                    def binary_return(a)
                        return a[0]*16+a[1]*8+a[2]*4+a[3]*2+a[4]
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

                    while run < message.length
						# Find the character from the index and store it in "store"
                        for x in 0..31
                            if char_list[x] == message[run]
                                store = x
                                break
                            end
                        end
                        check = []
                        change = []
						
                        binary_mem = binary_find(store)
                        for bite in 0..4
                            color = image.importPixel(pix)[0]
                            color_2 = color%2
                            color_code = binary_mem[pix%5]
                            color = color - color_2 + color_code
                            if color > 255
                                color -= 2
                            end
                            col_return = [color, image.importPixel(pix)[1], image.importPixel(pix)[2]]
                            image.exportPixel(pix, col_return)
                            pix += 1
                        end
                        run += 1
                    end
                    for x in 0..4
                        color = image.importPixel(run+x)[0]
                        color = color - ( 1 - color%2)
                        col_return = [color, image.importPixel(run+x)[1], image.importPixel(run+x)[2]]
                        image.exportPixel(pix+x, col_return)
                    end
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
                    char_list = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",".",","," ","?","!", nil]
                    while true
                        for n in 0..4
                            colors[n] = image.importPixel(n + 5*runs)[0]
                        end
                        for x in 0..4
                            char_val[x] = colors[x]%2
                        end
                        character = char_val[4]*1 + char_val[3]*2 + char_val[2]*4 + char_val[1]*8 + char_val[0]*16 
                        if character == 31
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