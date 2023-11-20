CC = gcc
CFLAGS:=
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	CFLAGS=-shared -fPIC
endif
ifeq ($(UNAME_S),Darwin)
	CFLAGS=-shared -fPIC -Wl,-undefined -Wl,dynamic_lookup
endif

libmain.so: main.c
	$(CC) $(CFLAGS) -o libmain.so main.c
