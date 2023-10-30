project(hello)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(SRC_LIST main.c helloworld.c hellolinux.c)

add_executable(hello ${SRC_LIST})