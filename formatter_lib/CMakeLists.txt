cmake_minimum_required(VERSION 3.8)
project(formatter)

set(SOURCE_LIB formatter.cpp formatter.h)

add_library(formatter STATIC ${SOURCE_LIB})

target_include_directories(formatter PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}) 