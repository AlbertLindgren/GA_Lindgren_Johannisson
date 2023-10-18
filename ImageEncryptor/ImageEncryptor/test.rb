require_relative 'rice_wrap'

imageManager = ImageManager.new

imageManager.loadImage("img/test1.png")
color = []
color = imageManager.importPixel(5)
puts "Width: #{imageManager.getWidth()}"
puts "Height: #{imageManager.getHeight()}"

