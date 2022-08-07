#  Use gimptool-2.0 to sett these variables
PLUGIN=fourier
VERSION=0.4.1
GIMPTOOL=gimptool-2.0
PLUGIN_BUILD=$(GIMPTOOL) --build
PLUGIN_INSTALL=$(GIMPTOOL) --install-bin
GCC=g++
CFLAGS=-Wall -O2 $(shell pkg-config fftw3 gimp-2.0 --cflags)
LIBS=$(shell pkg-config fftw3 gimp-2.0 --libs)
DIR=$(PLUGIN)-$(VERSION)
MKDIR=mkdir
COPY=cp
TAR=tar
RM=rm -f

export

FILES= \
    $(PLUGIN).c \
    Makefile \
    Makefile.win \
    README \
    README.Moire \
    $(PLUGIN).dev

all: fourier

# Use of pkg-config is the recommended way
$(PLUGIN): $(PLUGIN).o
	$(GCC) $^ $(LIBS) -o $@

$(PLUGIN).o: $(PLUGIN).c
	$(GCC) $(CFLAGS) -c $< -o $@

# To avoid gimptool use, just copy the fourier in the directory you want
install: $(PLUGIN)
	$(PLUGIN_INSTALL) $(PLUGIN)
	 
dist:
	$(MKDIR) $(DIR)
	$(COPY) $(FILES) $(DIR)
	$(TAR) -czf "$(DIR).tar.gz" $(DIR)
	$(RM) -R $(DIR)
   
clean:
	$(RM) $(PLUGIN).o $(PLUGIN)
