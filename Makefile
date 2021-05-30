CC				   ?= gcc
EMCC			   ?= emcc
CFLAGS			   ?= -Wall -Wextra -ggdb -std=c99 `pkg-config --cflags glfw3`
LIFLAGS			   ?= -I./include/linux
EMCCFLAGS		   ?= -I./include/webasm -s ASSERTIONS=1 --profiling -Os -D_DEFAULT_SOURCE -s USE_GLFW=3 -s ASYNCIFY -s TOTAL_MEMORY=67108864 -s FORCE_FILESYSTEM=1 
LIBS			   ?= -lraylib -lglfw -lrt -lm -ldl -lpthread `pkg-config --libs glfw3`
EMCCLIBS		   ?= -L./lib/webasm
LILIBS			   ?= -L/usr/local/lib -L./lib/linux/ -lX11 -lxcb -lXau -lXdmcp 
BUILDTYPE		   ?= BUILD_DEBUG
DESTDIR            ?= ./bin
DESTOBJ			   ?= $(DESTDIR)/game
BUILD_T			   ?= debug

ifeq ($(BUILDTYPE), BUILD_DEBUG)
	BUILD_T ?= debug
else
	ifeq ($(BUILDTYPE), BUILD_RELEASE)
		BUILD_T ?= release
	endif
endif

all install: debug

debug: linux

release: linux wasm

linux: src/main.c $(wildcard src/*c) $(wildcard src/*.h)
	$(CC) $(CFLAGS) $(LIFLAGS)  src/main.c $(LIBS) $(LILIBS) -o $(DESTOBJ)

wasm: src/main.c $(wildcard src/*c) $(wildcard src/*.h) 
	$(EMCC) $(CFLAGS) $(EMCCFLAGS)  src/main.c $(LIBS) $(EMCCLIBS) -o $(DESTDIR)/index.html
