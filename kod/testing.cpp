#include <iostream>
// Put this after includes:
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#include "stb_image_write.h"

// Create those functions!

// Function for loading images
unsigned char* loadImage(const char* path, int &width, int &height, int &channels)
{
	unsigned char* image = stbi_load("img/test1.png", &width, &height, &channels, 0);
	if (image == nullptr) {
		std::cout << "Error in loading the image\n";
		exit(1);
	}
	return image;
}

// Function to get pixels from image
int getPixel(unsigned char* img, int width, int channels, size_t x, size_t, size_t y)
{
	// Get RGBA values
	size_t index = channels * (y * width + x);

	std::cout << "Pixel: RGBA "
		<< static_cast<int>(img[index + 0]) << " "
		<< static_cast<int>(img[index + 1]) << " "
		<< static_cast<int>(img[index + 2]) << " "
		<< static_cast<int>(img[index + 3]) << "\n";
}

int main()
{
	int width, height, channels;
	unsigned char *image = stbi_load("img/test1.png", &width, &height, &channels, 0);
	if (image == nullptr) {
		std::cout << "Error in loading the image\n";
		exit(1);
	}
	// TODO:Check if image has 3 or 4 channels
	std::cout << "Loaded image with a width of: " << width << "and a height of: " << height << " and " << channels << "channels" << std::endl;

	/* 
	Total number of pixels : 0 - total, total = (width * height) / channels
	3 channels per pixel (ignore rgba) means 3*(width+height)
	Next pixel at least 3 pixels away from the first pixels R-value, which means, that the index is, image[index + 0]
	Image data consists of y lines of x pixels, first line y = 0 and x=0-width, after first line the full width has been traversed therefore index= 3 *(y*width+x)
	If I want the first pixel on the second line, y=1 (because 2=1 in index-speak), x=0, width is constant in this example, 800. 
	index = 4 * (y * width + x)
	*/
	int pixelTotal = (width * height) / channels;
	std::cout << "Pixel Total: " << pixelTotal << std::endl;

	// Get RGBA values
	const size_t RGBA = 4;
	size_t x, y;
	x = 500;
	y = 5;
	size_t index = RGBA * (y * width + x);

	std::cout << "Pixel: RGBA "	
		      << static_cast<int>(image[index + 0]) << " "
		      << static_cast<int>(image[index + 1]) << " "
		      << static_cast<int>(image[index + 2]) << " "
			  << static_cast<int>(image[index + 3]) << "\n";

	// Free memory
	stbi_image_free(image);
}