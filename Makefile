APPNAME = AjhcTest
ANDROID_TARGET = android-17

CDIR = jni
CSRC = $(wildcard $(CDIR)/*.c $(CDIR)/*.h)

HSBUILD = hs_build
HSDIR = hs_src
HSSRC = $(wildcard $(HSDIR)/*.hs $(HSDIR)/*/*.hs $(HSDIR)/*/*/*.hs $(HSDIR)/*/*/*/*.hs)
HSLIBDIR = ../lib

.PHONY: all release clean
all: bin/$(APPNAME)-debug.apk
release: bin/$(APPNAME).apk

bin/$(APPNAME)-debug.apk: $(HSBUILD)/hs_main.c $(CSRC)
	ndk-build NDK_DEBUG=1
	ant debug

bin/$(APPNAME).apk: $(HSBUILD)/hs_main.c $(CSRC)
	ndk-build
	ant release

$(HSBUILD)/hs_main.c: $(HSSRC)
	mkdir -p $(HSBUILD)
	ajhc -fffi -fpthread -L ${HSLIBDIR} --include=hs_src --tdir=$(HSBUILD) -C -o $@ $(HSSRC)

clean:
	rm -rf bin libs obj gen $(HSBUILD)
