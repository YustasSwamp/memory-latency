memtest: memtest.c
	$(CC) -O2 -g -o $@ $< -lpthread

clean:
	rm -f memtest
