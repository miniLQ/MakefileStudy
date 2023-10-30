project(hello)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(SRC_LIST main.c helloworld.c)

message(STATUS "This is BINARY dir " ${HELLO_BINARY_DIR})
message(STATUS "This is SOURCE dir " ${HELLO_SOURCE_DIR})

add_executable(hello ${SRC_LIST})