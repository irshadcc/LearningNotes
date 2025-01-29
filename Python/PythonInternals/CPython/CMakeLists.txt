cmake_minimum_required(VERSION 3.10)  # Or a suitable minimum version

project(MySimpleProgram)

set(CMAKE_CXX_STANDARD 17) 
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package (Python COMPONENTS Interpreter Development)

message(STATUS ${Python_LIBRARIES})
message(STATUS ${Python_INCLUDE_DIRS})


add_subdirectory(src)
