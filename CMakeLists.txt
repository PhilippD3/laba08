cmake_minimum_required(VERSION 3.8)

project(equation)

set(PRINT_VERSION_PATCH 0)
set(PRINT_VERSION_MINOR 1)
set(PRINT_VERSION_MAJOR 0)
set(PRINT_VERSION_TWEAK 0)
set(PRINT_VERSION ${PRINT_VERSION_MAJOR}.${PRINT_VERSION_MINOR}.${PRINT_VERSION_PATCH}.${PRINT_VERSION_TWEAK})
set(PRINT_VERSION_STRING "v${PRINT_VERSION}")

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib formatter_ex_new_name)

target_include_directories(formatter_ex PUBLIC formatter_ex_lib formatter_lib hello_world_application solver_lib)

add_library(solver ${CMAKE_CURRENT_SOURCE_DIR}/solver_lib/solver.cpp)

add_executable(equation ${CMAKE_CURRENT_SOURCE_DIR}/solver_application/equation.cpp)

target_link_libraries(equation formatter formatter_ex solver)

install(TARGETS equation
RUNTIME DESTINATION bin
)

include(CPackConfig.cmake)