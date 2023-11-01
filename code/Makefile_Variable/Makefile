
obj = add.o minus.o variable.o

program: $(obj)
	gcc -o program $(obj)
	
$(obj): defs.h

clean:
	rm *.o