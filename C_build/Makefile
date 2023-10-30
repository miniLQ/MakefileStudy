
world_static:
	gcc -E helloworld.c -o helloworld.i
	gcc -S helloworld.i -o helloworld.s
	gcc -c helloworld.s -o helloworld.o
	ar -r libhelloworld.a helloworld.o

linux_dynamic:
	gcc -E hellolinux.c -o hellolinux.i
	gcc -S hellolinux.i -o hellolinux.s
	gcc -c -fpic hellolinux.c -o hellolinux.o
	gcc --shared hellolinux.o -o libhellolinux.so

install:
	gcc main.c -o hello -lhelloworld -lhellolinux -L./ -Wl,-rpath=./

clean:
	rm -rf *.o *.i *.s *.a *.so hello
