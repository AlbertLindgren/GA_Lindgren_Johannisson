char_list = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",".",","," ","?","!", nil]
message = ""
run = 0
while run < 18
    value = rand(0...5)
    char_val = []
    char_val[0] = rand(0...2)%2
    char_val[1] = rand(0...2)%2
    char_val[2] = rand(0...2)%2
    char_val[3] = rand(0...2)%2
    char_val[4] = rand(0...2)%2
    character = char_val[0]*1 + char_val[1]*2 + char_val[2]*4 + char_val[3]*8 + char_val[4]*16 
    if character == 31
        break
    end
    message = message + char_list[character]
    run += 1
end

puts message