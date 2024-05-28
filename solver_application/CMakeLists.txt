cmake_minimum_required(VERSION 3.8)

project(equation)

include_directories("../formatter_ex_lib/")
include_directories("../solver_lib/")

add_executable(equation equation.cpp)

add_subdirectory("../formatter_ex_lib/" formatter_ex)
add_subdirectory("../solver_lib/" solver)

target_link_libraries(equation formatter_ex)
target_link_libraries(equation solver)

target_include_directories(equation PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}) 