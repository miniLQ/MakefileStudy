
hello_static:
	gcc -E helloworld.c -o helloworld.i
	gcc -S helloworld.i -o helloworld.s
	gcc -c helloworld.s -o helloworld.o
	ar -r libhello.a helloworld.o
	gcc main.c -o hello -lhello -L./

hello_dynamic:
	gcc -E helloworld.c -o helloworld.i
	gcc -S helloworld.i -o helloworld.s
	gcc -c -fpic helloworld.c -o helloworld.o
	gcc --shared helloworld.o -o libhello.so
	gcc main.c -o hello -lhello -L./ -Wl,-rpath=./

clean:
	rm -rf *.o *.i *.s *.a *.so hello
