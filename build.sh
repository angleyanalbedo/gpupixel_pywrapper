#!/bin/bash
#check if exist git cmake gcc
build_type=$1
if [ -z "$1" ]; then
    echo "No build type provided. Using default: Debug"
    build_type="Debug"
else
    build_type=$1
fi
check_git() {
    if ! command -v git &> /dev/null
    then
        echo "Error: 'git' command not found. Please install Git and try again."
        exit 1
    fi
    echo "Git is installed."
}

check_cmake() {
    if ! command -v cmake &> /dev/null
    then
        echo "Error: 'cmake' command not found. Please install CMake and try again."
        exit 1
    fi
    echo "CMake is installed."
}

check_gcc() {
    if ! command -v gcc &> /dev/null
    then
        echo "Error: 'gcc' command not found. Please install GCC and try again."
        exit 1
    fi
    echo "GCC is installed."
}

download_gpupixel(){
    # check if exist gpupixel directory
    if [ ! -d "gpupixel" ]; then
        git clone --depth 1 --branch v1.2.5 git@github.com:pixpark/gpupixel.git
    else
        echo "gpupixel directory found."
        echo "Do not clone the repository again."
    fi
}

build_gpupixel(){
    # check if exist gpupixel/src/target directory
    if [ ! -d "gpupixel/src/target" ]; then
        echo "Error: 'gpupixel/src/target' directory not found. Please clone the repository first."
        exit 1
    fi
    # check if exist gpupixel/src/third_party/stb directory
    if [ ! -d "gpupixel/src/third_party/stb" ]; then
        echo "Error: 'gpupixel/src/third_party/stb' directory not found. Please clone the repository first."
        exit 1
    fi
    cp ./src/target/target_raw_data_output.cc ./gpupixel/src/target/
    cp ./src/third_party/stb/stb_image_write.h ./gpupixel/src/third_party/stb/
    cd gpupixel
    echo "Building gpupixel... Please wait."
    echo "Build type: $build_type" 
    cmake -G "MinGW Makefiles" -B build -S src
    cmake --build build --config $build_type
    cd -
}

build_c++wrapper(){
    
    cp -r ./wrapper ./gpupixel/

    cd gpupixel
    echo "Building gpupixel... Please wait."
    echo "Build type: $build_type" 
    cmake -G "MinGW Makefiles" -B wrapper/build -S wrapper
    cmake --build wrapper/build --config $build_type
    cd -
}

build_python_wrapper(){

    cp -r ./pywrapper ./gpupixel/

    cd gpupixel
    echo "Building gpupixel... Please wait."
    echo "Build type: $build_type" 
    cmake -G "MinGW Makefiles" -B pywrapper/build -S pywrapper
    cmake --build pywrapper/build --config $build_type
    cd -
}


check_git
check_cmake
check_gcc
download_gpupixel

#build all
build_gpupixel
build_c++wrapper
build_python_wrapper
echo "Build completed successfully."




