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

	// Get image type, GIF(.gif), PNG(.png), BMP(.bmp)
	std::string image_path = path;
	std::string sub_str;
	size_t pos = image_path.find('.');
	if (pos != std::string::npos) {
		sub_str = image_path.substr(pos);
	}
	
	if (sub_str == ".png") {
		imageType = "png";
	}
	else if (sub_str == ".bmp") {
		imageType = "bmp";
	}
	else {
		std::cout << "ERROR! Unsupported image format.\n";
		exit(0);
	}
}

std::vector<int> ImageManager::importPixel(int nPixel)
{
	if (nPixel > (_width * _height))
	{
		std::cout << "CPP_ERROR: index exceeded pixel total: " << std::endl;
		exit(0);
	}
	_img = stbi_load(_path, &_width, &_height, &_channels, _channel_num);
	int index = 3 * nPixel;
	_rgb_pixel[0] = static_cast<int>(_img[index + 0]);
	_rgb_pixel[1] = static_cast<int>(_img[index + 1]);
	_rgb_pixel[2] = static_cast<int>(_img[index + 2]);

	return _rgb_pixel;
}

void ImageManager::exportPixel(int nPixel, std::vector<int> colour)
{
	if (nPixel > (_width * _height))
	{
		std::cout << "CPP_ERROR: index exceeded pixel total: " << std::endl;
		exit(0);
	}
	_img = stbi_load(_path, &_width, &_height, &_channels, _channel_num);
	uint8_t* c_pixels = new uint8_t[_width * _height * _channel_num];
	int index = 3 * nPixel;
	for (int i = 0; i < (_width * _height * _channel_num); i++) {
		c_pixels[i] = static_cast<int>(_img[i]);
	}
	
	c_pixels[index] = colour[0];
	c_pixels[index + 1] = colour[1];
	c_pixels[index + 2] = colour[2];

	// Write based on format
	if (imageType == "png") {
		stbi_write_png(_path, _width, _height, _channel_num, c_pixels, _width * _channel_num);
	}
	else if (imageType == "bmp") {
		stbi_write_bmp(_path, _width, _height, _channel_num, c_pixels);
	}

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