project(hello)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(SRC_LIST main.c)

# Add the following lines to create a shared library from helloworld.c and hellolinux.c
add_library(libhello SHARED helloworld.c hellolinux.c)

# Link the executable hello with the shared library hello
add_executable(hello ${SRC_LIST})
target_link_libraries(hello libhello)

add_executable(hello ${SRC_LIST})