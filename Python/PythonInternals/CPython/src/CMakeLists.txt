


add_executable(
    cpython_demo 
    main.cpp
)

target_link_libraries(
    cpython_demo
    ${Python_LIBRARIES}
)

target_include_directories(
    cpython_demo
    PUBLIC
    ${Python_INCLUDE_DIRS}
)