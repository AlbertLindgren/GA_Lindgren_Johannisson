require_relative 'rice_wrap'

def dekrypt(path)
    image = ImageManager.new
    image.loadImage(path)
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
            return message
        end
        message = message + char_list[character]
        runs += 1
    end
end
#path = gets.chomp
#puts dekrypt("img/general_kenobi.png")
#puts dekrypt(path)