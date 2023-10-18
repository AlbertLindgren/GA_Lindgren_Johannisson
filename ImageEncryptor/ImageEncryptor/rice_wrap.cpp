#include "image_manager.h"
#include "rice/rice.hpp"
#include "rice/stl.hpp"

using namespace Rice;

extern "C"
void Init_rice_wrap()
{
	Data_Type<ImageManager> rb_cImageManager =
		define_class<ImageManager>("ImageManager")
		.define_constructor(Constructor<ImageManager>())
		.define_method("loadImage", &ImageManager::loadImage)
		.define_method("importPixel", &ImageManager::importPixel)
		.define_method("exportPixel", &ImageManager::exportPixel)
		.define_method("getWidth", &ImageManager::getWidth)
		.define_method("getHeight", &ImageManager::getHeight);
		
	define_vector<std::vector<int>>("IntVector");
}