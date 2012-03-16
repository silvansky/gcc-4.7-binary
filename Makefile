HOME := ${HOME}
INSTALL_DIR = ${HOME}/gcc
PWD := ${PWD}

CORES=8

# for mac os x on first build of gcc
# this is to ensure gcc will know about the memory model
#CC = clang
#CXX = clang++

# Default target executed when no arguments are given to make.
default_target: all

all: gcc
	@echo ''
	@echo '---------------------------'
	@echo '  compiling complete'
	@echo '  remember to run: make install'
	@echo '  and to update your ~/.bash_profile '
	@echo '  PATH=${INSTALL_DIR}:$$PATH '
	@echo '---------------------------'
	@echo ''

gmp: unpack
	@echo ''
	@echo '---------------------------'
	@echo '  gmp compiling'
	@echo '---------------------------'
	@echo ''
	cd gmp/build; \
		../configure --prefix=${PWD}/build; \
		make -j ${CORES}; \
		make install;
	@echo ''
	@echo '---------------------------'
	@echo '  gmp compiled'
	@echo '---------------------------'
	@echo ''

mpfr: unpack gmp
	@echo ''
	@echo '---------------------------'
	@echo '  mpfr compiling'
	@echo '---------------------------'
	@echo ''
	cd mpfr/build; \
		../configure  --prefix=${PWD}/build \
		--with-gmp=${PWD}/build;  \
		make -j ${CORES}; \
		make install;
	@echo ''
	@echo '---------------------------'
	@echo '  mpfr compiled'
	@echo '---------------------------'
	@echo ''

mpc: unpack gmp mpfr
	@echo ''
	@echo '---------------------------'
	@echo '  mpc compiling'
	@echo '---------------------------'
	@echo ''
	cd mpc/build; \
		../configure --prefix=${PWD}/build \
		--with-gmp=${PWD}/build \
		--with-mpfr=${PWD}/build; \
		make -j ${CORES}; \
		make install;
	@echo ''
	@echo '---------------------------'
	@echo '  mpc compiled'
	@echo '---------------------------'
	@echo ''

gcc: unpack gmp mpfr mpc
	@echo ''
	@echo '---------------------------'
	@echo '  gcc compiling'
	@echo '---------------------------'
	@echo ''
	cd gcc/build; \
		../configure --prefix=${INSTALL_DIR} \
		--enable-checking=release \
		--with-gmp=${PWD}/build/ \
		--with-mpfr=${PWD}/build/ \
		--with-mpc=${PWD}/build/; \
		make -j ${CORES};
	@echo ''
	@echo '---------------------------'
	@echo '  gcc compiled'
	@echo '---------------------------'
	@echo ''

unpack: fetch
	@echo ''
	@echo '---------------------------'
	@echo '  unpacking sources'
	@echo '---------------------------'
	@echo ''
	if [ ! -d ./gmp ]; then \
		tar jxvf gmp*.bz2; \
		mv gmp*/ gmp; \
		mkdir gmp/build; \
	fi
	if [ ! -d ./mpc ]; then \
		tar zxvf mpc*.gz; \
		mv mpc*/ mpc; \
		mkdir mpc/build; \
	fi
	if [ ! -d ./mpfr ]; then \
		tar jxvf mpfr*.bz2; \
		mv mpfr*/ mpfr; \
		mkdir mpfr/build; \
	fi
	if [ ! -d ./gcc ]; then \
		tar jxvf gcc*.bz2; \
		mv gcc*/ gcc; \
		mkdir gcc/build; \
	fi
	if [ ! -d ${INSTALL_DIR} ]; then \
		mkdir ${INSTALL_DIR}; \
	fi
	if [ ! -d ./build ]; then \
		mkdir build; \
	fi
	@echo ''
	@echo '---------------------------'
	@echo '  all unpacked'
	@echo '---------------------------'

fetch:
	@echo ''
	@echo '---------------------------'
	@echo '  downloading sources'
	@echo '---------------------------'
	@echo ''
	if [ ! -f gmp*.bz2 ]; then \
		wget -nc ftp://ftp.gmplib.org/pub/gmp-5.0.4/gmp-5.0.4.tar.bz2; \
	fi
	if [ ! -f mpfr*.bz2 ]; then \
		wget -nc http://www.mpfr.org/mpfr-current/mpfr-3.1.0.tar.bz2; \
	fi
	if [ ! -f mpc*.gz ]; then \
		wget -nc http://www.multiprecision.org/mpc/download/mpc-0.9.tar.gz; \
	fi
	if [ ! -f gcc*.bz2 ]; then \
		wget -nc http://www.netgull.com/gcc/snapshots/4.7.0-RC-20120314/gcc-4.7.0-RC-20120314.tar.bz2; \
	fi
	@echo ''
	@echo '---------------------------'
	@echo '  sources downloaded'
	@echo '---------------------------'
	@echo ''

install:
	cd gcc/build; make install

# Clean Targets
clean:
	rm -rf gmp mpc mpfr gcc ${INSTALL_DIR} ${PWD}/build

clean-all: clean
	rm -rf *.bz2 *.gz

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean (removes source directories)"
	@echo "... clean-all (removes source directories and tarballs)"
	@echo "... fetch"
	@echo "... gcc"
	@echo "... gmp"
	@echo "... install"
	@echo "... mpc"
	@echo "... mpfr"
	@echo "... unpack"