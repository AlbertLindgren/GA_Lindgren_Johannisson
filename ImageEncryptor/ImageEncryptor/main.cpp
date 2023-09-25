#include <iostream>
// Put this last:
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"


int main()
{
	int width, height, channels;
	unsigned char *image = stbi_load("img/test1.png", &width, &height, &channels, 3);
	if (image == NULL) {
		std::cout << "Error in loading the image\n";
		exit(1);
	}
	std::cout << "Loaded image with a width of: " << width << "and a height of: " << height << " and " << channels << "channels" << std::endl;
}