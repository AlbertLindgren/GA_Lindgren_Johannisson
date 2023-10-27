require_relative 'rice_wrap'

image = ImageManager.new

image.loadImage("img/test2.png")
puts "Width: #{image.getWidth()}"
puts "Height: #{image.getHeight()}"

# Import pixel test
og_color = []
n = 5

og_color[0] = image.importPixel(n)[0]
og_color[1] = image.importPixel(n)[1]
og_color[2] = image.importPixel(n)[2]

p og_color

# Export pixel test
color_c = [255,255,255]
color2 = [100, 32, 87]
x = 1

while(true)
    image.exportPixel(n, color_c)
    sleep(0.5)
    p image.importPixel(n)[0]
    image.exportPixel(n, color2)
    p "CHANGE!"
    sleep(0.5)
    p image.importPixel(n)[0]
end