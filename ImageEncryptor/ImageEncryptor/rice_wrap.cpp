#include "image_manager.h"
#include "../../libraries/rice-master/rice/rice.hpp"
#include "../../libraries/rice-master/rice/stl.hpp"

using namespace Rice;

extern "C"
void Init_test()
{
	Data_Type<ImageManager> rb_cImageManager =
		define_class<ImageManager>("ImageManager")
		.define_constructor(Constructor<ImageManager>())
		.define_method("loadImage", &ImageManager::loadImage)
		.define_method("importPixel", &ImageManager::importPixel)
		.define_method("exportPixel", &ImageManager::exportPixel)
		.define_method("getWidth", &ImageManager::getWidth);
}		