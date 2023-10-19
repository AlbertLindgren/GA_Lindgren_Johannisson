#include "image_manager.h"

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

ImageManager::ImageManager()
{
	_rgb_pixel = { 0, 0, 0 };
}

ImageManager::~ImageManager()
{
	stbi_image_free(_img);
}

void ImageManager::loadImage(const char* path)
{
	_path = path;
	_img = stbi_load(path, &_width, &_height, &_channels, _channel_num);
}

std::vector<int> ImageManager::importPixel(int nPixel)
{
	int index = 3 * nPixel;
	_rgb_pixel[0] = static_cast<int>(_img[index + 0]);
	_rgb_pixel[1] = static_cast<int>(_img[index + 1]);
	_rgb_pixel[2] = static_cast<int>(_img[index + 2]);

	return _rgb_pixel;
}

void ImageManager::exportPixel(int nPixel, std::vector<int> colour)
{

	uint8_t* c_pixels = new uint8_t[_width * _height * _channel_num];
	int index = 3 * nPixel;
	for (int i = 0; i < (_width * _height * _channel_num); i++) {
		c_pixels[i] = static_cast<int>(_img[i]);
	}
	
	c_pixels[index] = colour[0];
	c_pixels[index + 1] = colour[1];
	c_pixels[index + 2] = colour[2];

	stbi_write_png(_path, _width, _height, _channel_num, c_pixels, _width * _channel_num);
	delete[] c_pixels;
}

int ImageManager::getWidth()
{
	return _width;
}

int ImageManager::getHeight()
{
	return _height;
}

int main() {
	return 0;
}