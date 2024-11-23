.PHONY: clean

test_ll_cycle: test_ll_cycle.o ll_cycle.o
	gcc -o test_ll_cycle test_ll_cycle.o ll_cycle.o

ll_cycle.o: ll_cycle.c
	gcc -c ll_cycle.c

test_ll_cycle.o: test_ll_cycle.c ll_cycle.h
	gcc -c test_ll_cycle.c

clean:
	rm -f *.exe
	rm -f *.o
	rm -f eccentric
	rm -f hello
	rm -f int_hello
	rm -f no_segfault_ex
	rm -f segfault_ex
	rm -f test_ll_cycle
