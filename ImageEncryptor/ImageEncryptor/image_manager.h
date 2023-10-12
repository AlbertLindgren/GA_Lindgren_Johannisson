#ifndef IMAGE_MANAGER
#define IMAGE_MANAGER

/* Class containing functions for loading image, storing important information in variables which can be accessed with get methods
* and functions for getting and changing pixels. 
*/

class ImageManager
{
public:

	ImageManager();
	~ImageManager();

	unsigned char* loadImage(const char* path);
	int importPixel(unsigned char* img);
	int exportPixel(unsigned char* img);


	// Get functions
	int getWidth();
	int getHeight();
	int getChannels();

private:
	unsigned char* img;
	int width;
	int height;
	int channels;
	int n_pixel; // Coordinate of current pixel, First pixel = channels * (0 * width + 0); Pixel = 
};

#endif // IMAGE_MANAGER