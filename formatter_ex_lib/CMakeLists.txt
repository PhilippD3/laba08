cmake_minimum_required(VERSION 3.8)

project(formatter_ex)

add_library(formatter_ex STATIC formatter_ex.cpp)

add_subdirectory("../formatter_lib" formatter)

target_link_libraries(formatter_ex PUBLIC formatter)
target_include_directories(formatter_ex PUBLIC
				"../formatter_ex_lib"
				"../formatter_lib")

target_include_directories(formatter_ex PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}) 