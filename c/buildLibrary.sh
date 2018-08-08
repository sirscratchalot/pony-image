gcc -c ./getPixel.c -o pixelwand.o -I /usr/include/ImageMagick-6/ -I /usr/include/x86_64-linux-gnu/ImageMagick-6/  -DMAGICKCORE_HDRI_ENABLE=0 -DMAGICKCORE_QUANTUM_DEPTH=16
ar rcs libpixelwand.a pixelwand.o
