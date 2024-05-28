cmake_minimum_required(VERSION 3.8)
project(solver)

set(SOURCE_LIB solver.cpp solver.h)

add_library(solver STATIC ${SOURCE_LIB})

target_include_directories(solver PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}) 