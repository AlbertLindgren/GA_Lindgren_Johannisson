#include "image_manager.h"
#include "../../libraries/rice-master/rice/rice.hpp"
#include "../../libraries/rice-master/rice/stl.hpp"

using namespace Rice;

extern "C"
void Init_test()
{
	Data_Type<ImageManager> rb_cImageManager = 
		define_class<ImageManager>("ImageManager")

}