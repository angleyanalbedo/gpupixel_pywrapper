#include "gpupixel_wrapper.h"

extern "C" {
    typedef void* GPUPixelWrapperPtr;

    GPUPixelWrapperPtr GPUPixelWrapper_create() {
        return new GPUPixelWrapper();
    }

    bool GPUPixelWrapper_initialize(GPUPixelWrapperPtr self) {
        return reinterpret_cast<GPUPixelWrapper*>(self)->initialize();
    }

    void GPUPixelWrapper_setCallbacks(GPUPixelWrapperPtr self) {
#ifdef _DEBUG
        std::cout << "GPUPixelWrapper_setCallbacks" << std::endl;
#endif
        reinterpret_cast<GPUPixelWrapper*>(self)->setCallbacks();
    }

    void GPUPixelWrapper_setParameters(GPUPixelWrapperPtr self, float beautyValue, float whithValue, float thinFaceValue, float bigeyeValue, float lipstickValue, float blusherValue) {
#ifdef _DEBUG
        std::cout << "GPUPixelWrapper_setParameters: beautyValue=" << beautyValue << ", whithValue=" << whithValue << ", thinFaceValue=" << thinFaceValue << ", bigeyeValue=" << bigeyeValue << ", lipstickValue=" << lipstickValue << ", blusherValue=" << blusherValue << std::endl;
#endif
        reinterpret_cast<GPUPixelWrapper*>(self)->setParameters(beautyValue, whithValue, thinFaceValue, bigeyeValue, lipstickValue, blusherValue);
    }

    void* GPUPixelWrapper_run(GPUPixelWrapperPtr self, const uint8_t* inputData, int width, int height, int channel) {
#ifdef _DEBUG
        std::cout << "GPUPixelWrapper_run: inputData=" << static_cast<const void*>(inputData) << ", width=" << width << ", height=" << height << ", channel=" << channel << std::endl;
#endif
        return reinterpret_cast<GPUPixelWrapper*>(self)->forward(inputData, width, height, channel);
    }

    void GPUPixelWrapper_release(GPUPixelWrapperPtr self) {
#ifdef _DEBUG
        std::cout << "GPUPixelWrapper_release" << std::endl;
#endif
        reinterpret_cast<GPUPixelWrapper*>(self)->release();
    }

    void GPUPixelWrapper_destroy(uint8_t* outputData) {
#ifdef _DEBUG
        std::cout << "GPUPixelWrapper_destroy: outputData=" << static_cast<const void*>(outputData) << std::endl;
#endif
        free(outputData);
    }
}
