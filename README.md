This is the Mac OSX binary for the stable release gcc-4.7.0, this file is provided for your convenience, if you prefer to compile yourself gcc-4.7 visit the tutorial webpage for build instructions:

[http://solarianprogrammer.com/2012/02/20/living-on-the-edge-building-gcc-4-7-on-mac-osx-lion/](http://solarianprogrammer.com/2012/02/20/living-on-the-edge-building-gcc-4-7-on-mac-osx-lion/)

**Clone (download) the archive on your machine with:**

git clone git://github.com/sol-prog/gcc-4.7-binary.git

In order to install this binary extract gcc-4.7.tar.bz2 and copy the extracted folder (gcc-4.7) in your /usr folder.

Using the new compilers (gcc-4.7, g++-4.7 and gfortran-4.7) require that you modify your shell path, paste the next line in a Terminal session:

export PATH=/usr/gcc-4.7/bin:$PATH

Compiling a C++11 code is as simple as:

g++-4.7 -std=c++11 file_name.cpp -o file_name:

If you need more help leave me a comment at:

[http://solarianprogrammer.com/2012/02/20/living-on-the-edge-building-gcc-4-7-on-mac-osx-lion/](http://solarianprogrammer.com/2012/02/20/living-on-the-edge-building-gcc-4-7-on-mac-osx-lion/)
