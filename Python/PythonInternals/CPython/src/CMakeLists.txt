

set(DEMO_SRCS 
   main.cpp
   my_math.cpp
   demo.cpp
) 

set(DEMO_LIBS ${Python_LIBRARIES})

set(DEMO_INCLUDES ${Python_INCLUDE_DIRS})

# Executable
# ====================
add_executable(cpython_demo ${DEMO_SRCS})
target_link_libraries(cpython_demo ${DEMO_LIBS})
target_include_directories(cpython_demo PUBLIC ${DEMO_INCLUDES})

# Shared library
add_library(demo SHARED ${DEMO_SRCS})
target_link_libraries(demo ${DEMO_LIBS})
target_include_directories(demo PUBLIC ${DEMO_INCLUDES})
set_target_properties(demo PROPERTIES PREFIX "")

install(
    TARGETS
    demo
    DESTINATION
    ${CMAKE_CURRENT_SOURCE_DIR}
)
