#ifndef IMAGE_MANAGER
#define IMAGE_MANAGER

#include <vector>
#include <iostream>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#include "stb_image_write.h"


/* Class containing functions for loading image, storing important information in variables which can be accessed with get methods
* and functions for getting and changing pixels.
Idea: Create object that holds and tracks the current values of the relevant variables. 
Ruby program sends image path -> c++ function takes it in
Idea for prototype:
Take in image path for every function call and track pixels with integer from ruby loop. 
Return pixel by using std::array. 
*/

class ImageManager
{
public:

	ImageManager();
	~ImageManager();

	unsigned char* loadImage(const char* path); // returns img
	std::vector<int> importPixel(int nPixel); // choose pixel and get colour values
	void exportPixel(int nPixel, std::vector<int> colour);

	// Get functions
	//int getWidth();
	//int getHeight();
	//int getChannels();

private:
	unsigned char* _img;
	int _width;
	int _height;
	int _channels;
	std::vector<int> _rgb_pixel;
	const int _channel_num = 3;
};

#endif // IMAGE_MANAGER