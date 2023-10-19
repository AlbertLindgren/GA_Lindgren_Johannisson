require_relative 'dekryptering'
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
    p a[0]
    return a[0]*16+a[1]*8+a[2]*4+a[3]*2+a[4]
end


puts "Enter message: "
message = gets.chomp
puts "Enter filepath: "
path = gets.chomp
length = 5
number = 0
run = 0
digit_mem = []
store = 0
char_val = []

# Load image
image = ImageManager.new
image.loadImage(path)

while run < message.length
    for x in 0..31
        if char_list[x] == message[run]
            store = x
            break
        end
    end
    og_col = []
    change = []
    binary_mem = binary_find(store)
    while number < length #number är bara vilken bit man är på
        #og_col[0] = image.importPixel(run)[0]
		#og_col[1] = image.importPixel(run)[1]
		#og_col[2] = image.importPixel(run)[2]    #Detta ska vara funktionen som tar in färg värdet
        og_col[number] = color
        color_2 = color%2
        color_code = binary_mem[number]

        color = color - color_2 + color_code #Detta är inte så den ska funka, jag ska istället göra flera steg där jag tar flera värden men det kommer vara typ så här.
        if color > 255
            color -= 2
        end
        #Här ska det vara en funktion som tar "color" som en integer och ändrar pixeln till den färgen
        change[number] = color
		#image.exportPixel(run, change)
        number += 1
    end

    p og_col
    p change
    change = change + [1,1,1,1,1]
    p change
    puts dekrypt(change, "")
    run += 1
end


