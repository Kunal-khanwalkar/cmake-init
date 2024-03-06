#!/bin/sh

cat << "EOF"

  ____ __  __       _          ___       _ _   
 / ___|  \/  | __ _| | _____  |_ _|_ __ (_) |_ 
| |   | |\/| |/ _` | |/ / _ \  | || '_ \| | __|
| |___| |  | | (_| |   <  __/  | || | | | | |_ 
 \____|_|  |_|\__,_|_|\_\___| |___|_| |_|_|\__|

EOF

echo "Let's initialize your CMake project!\n"

read -p "Project name: " PROJECT_NAME && PROJECT_NAME=$(echo "${PROJECT_NAME}" | tr ' ' '-')
read -p "CMake version (Default - 3.0.0): " CMAKE_VERSION && CMAKE_VERSION=${CMAKE_VERSION:-3.0.0}
read -p "C++ Standard (Default - gnu++99): " CXX_STANDARD && CXX_STANDARD=${CXX_STANDARD:-99}
read -p "Project ingress point (Default - main.cpp): " INGRESS_POINT && INGRESS_POINT=${INGRESS_POINT:-main.cpp}

mkdir ${PWD}/src
mkdir ${PWD}/include
mkdir ${PWD}/out
touch ${PWD}/${INGRESS_POINT}

# Creating your CMakeLists.txt
cat << EOF > ${PWD}/CMakeLists.txt
cmake_minimum_required(VERSION ${CMAKE_VERSION})

project(${PROJECT_NAME})

set (CMAKE_CXX_STANDARD ${CXX_STANDARD})
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY "out/")
add_executable(${PROJECT_NAME} "${INGRESS_POINT}")
target_include_directories(${PROJECT_NAME} PUBLIC "\${CMAKE_CURRENT_SOURCE_DIR}/include/")
target_sources(${PROJECT_NAME} PRIVATE "\${CMAKE_CURRENT_SOURCE_DIR}/src/")
EOF

echo "\nCMakeLists.txt generated!"

# gitignore for ignoring the CMake generated files
cat << EOF > ${PWD}/.gitignore
CMakeFiles/
CMakeCache.txt
cmake_install.cmake
Makefile
out/
EOF

echo ".gitignore also created to manage the clutter (Give headpats! :])!"
