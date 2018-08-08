# Pony Image Reader

Learning project utilizing the Pony and the ImageMagick MagickWand Library to read images and calculate their average color.
The color of each is then printed to the command line.
## Implementation
The program takes a single argument, a folder.
Files in this folder will be filtered by filename endings, the program will then read and calculate the average color of each image in parallel.

To do this the program has two parts:
1. The core program written in Pony
1. A C library written for easy interoperability with Pony, this reads a file provided by the pony program and recodes all pixels into a 2D array of structs that can be parsed via FFI.

## Dependencies
The program depends on PonyC and Pony Stable.
The program depends on version 16 of MagickWand, this can be installed as a shared library on Ubuntu 18.04 using:
`apt install libmagickwand-dev`

## Build and usage instructions
To build both the c library and the pony-image program:
```bash
git clone https://github.com/chargedpeptide/pony-image
cd pony-image
./buildAll.sh
```

Then run the program with a single argument pointing to a folder of images:
`./pony-image ../folder-of-images`

