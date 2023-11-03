project(program)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(SRC_LIST variable.c add.c minus.c)

add_executable(program ${SRC_LIST})
