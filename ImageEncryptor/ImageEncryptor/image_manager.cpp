#include "image_manager.h"
#include <iostream>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#include "stb_image_write.h"

ImageManager::ImageManager()
{
	

}

ImageManager::~ImageManager()
{
	stbi_image_free(img);
}

int ImageManager::importPixel()