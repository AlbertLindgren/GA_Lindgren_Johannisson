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
run = 0
digit_mem = []
store = 0
pix = 0
char_val = []
orig_col = []

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
    for bite in 0..4
        color = image.importPixel(pix)[0]  
        orig_col[pix] = image.importPixel(pix)[0]
        og_col[1] = image.importPixel(pix)[1]
        og_col[2] = image.importPixel(pix)[2] 
        color_2 = color%2
        color_code = binary_mem[pix%5]
        color = color - color_2 + color_code #Detta är inte så den ska funka, jag ska istället göra flera steg där jag tar flera värden men det kommer vara typ så här.
        if color > 255
            color -= 2
        end
        col_return = [color, og_col[1], og_col[2]]
        #Här ska det vara en funktion som tar "color" som en integer och ändrar pixeln till den färgen
        p col_return
        p orig_col[pix]
	    image.exportPixel(pix, col_return)
        pix += 1
    end
    run += 1

end

for x in 1..5
    og_col[0] = image.importPixel(run+x)[0]
	og_col[1] = image.importPixel(run+x)[1]
	og_col[2] = image.importPixel(run+x)[2] 
    col_return = [og_col[0], og_col[1], og_col[2]]
    image.exportPixel(pix+x, col_return)
end
#puts dekrypt(change, "")

for x in 0..2
    og_col[0] = image.importPixel(x)[0]

    p og_col[0]
    p orig_col[x]
end
