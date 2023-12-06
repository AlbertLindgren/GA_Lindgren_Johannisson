#require_relative 'rice_wrap'
#
#image = ImageManager.new
#
#image.loadImage("img/test2.png")
#puts "Width: #{image.getWidth()}"
#puts "Height: #{image.getHeight()}"
#
## Import pixel test
#og_color = []
#n = 5
#
#og_color[0] = image.importPixel(n)[0]
#og_color[1] = image.importPixel(n)[1]
#og_color[2] = image.importPixel(n)[2]
#
#p og_color
#
## Export pixel test
#color_c = [255,255,255]
#color2 = [100, 32, 87]
#x = 1
#
#while(true)
#    image.exportPixel(n, color_c)
#    sleep(0.5)
#    p image.importPixel(n)[0]
#    image.exportPixel(n, color2)
#    p "CHANGE!"
#    sleep(0.5)
#    p image.importPixel(n)[0]
#end

char_list = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","."," ","1","2","3","4","5","6","7","8","9","0", nil]
puts char_list.length                 

def binary_find(a)
    digit_mem = []
    puts "siffra_orig"
    puts a
    digit_mem[0] = (a/16).floor
    puts "(a/16).floor"
    puts (a/16).floor

    a -= digit_mem[0]*16
    puts "a"
    p a

    digit_mem[1] = (a/4).floor
    a -= digit_mem[1]*4
    digit_mem[2] = a
    return digit_mem
end

def binary_return(a)
    return a[0]*16+a[1]*4+a[2]
end

while true
    puts "Message"
    message = gets.chomp
    for x in 0..63
        if char_list[x] == message[0]
            store = x
            break
        end
    end
    puts "Positionen som tecknet är på i listan"
    puts store
    puts "De bits som går till den positionen"
    p binary_find(store)
    binary = binary_find(store)
    puts "Den position i listan tacknet är"
    puts binary_return(binary)
    puts "Nya tecknet, helst samma som innan"
    puts char_list[binary_return(binary)]
end