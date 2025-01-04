cmake_minimum_required(VERSION 3.27)

project(ArrowDemo)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_PREFIX_PATH cmake)
include(FetchContent)

set(CMAKE_EXPORT_COMPILE_COMMANDS "ON")
include(cmake/FindBoost)

find_package(Arrow REQUIRED)

add_subdirectory(src)
