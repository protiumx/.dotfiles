CC = gcc
CFLAGS:=
LIBNAME:=
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	CFLAGS=-shared -fPIC
	LIBNAME=libnvim.so
endif
ifeq ($(UNAME_S),Darwin)
	CFLAGS=-shared -fPIC -Wl,-undefined -Wl,dynamic_lookup
	LIBNAME=libnvim.dylib
endif

libnvim.so: main.c
	$(CC) $(CFLAGS) -o $(LIBNAME) main.c
