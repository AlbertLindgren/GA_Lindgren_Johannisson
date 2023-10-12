#ifndef IMAGE_MANAGER
#define IMAGE_MANAGER

/* Class containing functions for loading image, storing important information in variables which can be accessed with get methods
* and functions for getting and changing pixels.
Idea: Create object that holds and tracks the current values of the relevant variables. 
Ruby program sends image path -> c++ function takes it in
*/

class ImageManager
{
public:

	ImageManager();
	~ImageManager();

	unsigned char* loadImage(const char* path); // returns img
	int importPixel(unsigned char* img); // choose pixel
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
	int currentPixel;
	int nPixel; // pixel number
};

#endif // IMAGE_MANAGER