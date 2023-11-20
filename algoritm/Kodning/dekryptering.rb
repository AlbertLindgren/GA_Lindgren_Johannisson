require_relative 'rice_wrap'


runs = 0

def dekrypt(path)
    image = ImageManager.new
    image.loadImage(path)
    char_val = []
    char_list = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",".",","," ","?","!", nil]
    while x = 1
        for n in 0..4
            colors[n] = image.importPixel(n + 4*runs)[0]
        for x in 0..4
            char_val[x] = colors[x]%2
        end
        character = char_val[4]*1 + char_val[3]*2 + char_val[2]*4 + char_val[1]*8 + char_val[0]*16 
        if character == 31
            return message
        end
        p character
        p char_list[character]
        message = message + char_list[character]
        runs += 1
    end
end
p "hello"
puts dekrypt(img/general_kenobi.png)