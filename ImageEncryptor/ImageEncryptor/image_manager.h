#ifndef IMAGE_MANAGER
#define IMAGE_MANAGER

#include <iostream>
#include <vector>
#include <string>



/* Class containing functions for loading image, storing important information in variables which can be accessed with get methods
* and functions for getting and changing pixels.
Ruby program sends image path -> c++ function takes it in
*/

class ImageManager
{
public:

	ImageManager();
	~ImageManager();

	void loadImage(const char* path); // returns img
	std::vector<int> importPixel(int nPixel); // choose pixel and get colour values
	void exportPixel(int nPixel, std::vector<int> colour);

	// Get functions
	int getWidth();
	int getHeight();
private:
	unsigned char* _img;
	std::string imageType;
	int _width;
	int _height;
	int _channels;
	std::vector<int> _rgb_pixel;
	const int _channel_num = 3;
	const char* _path;
};
#endif // IMAGE_MANAGER