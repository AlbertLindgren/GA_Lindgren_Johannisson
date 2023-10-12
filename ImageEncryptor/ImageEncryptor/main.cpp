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

int importPixel(int coordinate)
{

	// return color (color är [r,b,g])
}

void exportPixel(int colors[])
{

}


int main()
{
	int width, height,

	// Free memory
	stbi_image_free(image);
}