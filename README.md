# Pony Image Reader

Learning project utilizing the Pony and the ImageMagick MagickWand Library to read images and calculate their average color.
The color of each is then printed to the command line.
## Implementation
This branch is included simply for performance comparisons with the main branch.
The program takes a single argument, a folder.
Files in this folder will be filtered by filename endings, the program will then read the image file and print the first 100 pixels as text.
This program converts the image in memory using MagickWand MagickGetImageBlob method into text, this turned out to be a very slow implementation. 

A more performant implementation can be found in the master branch of this repository.

## Dependencies
The program depends on PonyC and Pony Stable.
The program depends on version 16 of MagickWand, this can be installed as a shared library on Ubuntu 18.04 using:
`apt install libmagickwand-dev`

## Build and usage instructions
To build both the c library and the pony-image program:

```bash
git clone https://github.com/chargedpeptide/pony-image
cd pony-image
git checkout text-ffi
./build.sh
```

Then run the program with a single argument pointing to a folder of images:
`./pony-image ../folder-of-images`

