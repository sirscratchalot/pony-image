#include <wand/magick-wand.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

typedef struct Pixel {
  double red;
  double blue;
  double green;
  double alpha;
  double depth;
} Pixel;

Pixel** pixelWandGet(char*,size_t*,size_t*);
Pixel** pixelWandGet(char* file,size_t* outwidth,size_t* outheight)
{
  MagickWand *mwand = NULL;
  PixelIterator *iterator = NULL;

  size_t x = 0;
  size_t y = 0;
  size_t xpixel = 0;
  size_t ypixel = 0;

 // MagickWandGenesis(); //Genesis and Terminus code moved to parent pony program
  mwand=NewMagickWand();
  MagickBooleanType bool = MagickReadImage(mwand,file);
  MagickSetImageType (mwand, TrueColorType);
  MagickSetImageColorspace (mwand, sRGBColorspace);
  if(!bool){
    printf("Could not read provided file!");
    return NULL;
  }
    

  PixelWand **pixelWands;
  iterator=NewPixelIterator(mwand);
  unsigned long width;
  MagickPixelPacket pixel;

  xpixel=MagickGetImageWidth(mwand);
  ypixel=MagickGetImageHeight(mwand);
  *outwidth =xpixel;
  *outheight = ypixel;
  Pixel **pixels=(Pixel **)malloc(xpixel*sizeof(Pixel *));
  for(x=0;x<xpixel;x++){
    pixels[x]=(Pixel *)malloc(ypixel*sizeof(Pixel));
  } 
  for (y=0; y < ypixel-1; y++)
    {
      pixelWands=PixelGetNextIteratorRow(iterator,&width);

      for (x=0; x < xpixel; x++)
        {
          PixelGetMagickColor(pixelWands[x],&pixel);
          pixels[x][y].red = pixel.red; 
          pixels[x][y].blue = pixel.blue;
          pixels[x][y].green = pixel.green;
          pixels[x][y].alpha = pixel.opacity;
          pixels[x][y].depth = pixel.depth;
          //printf("Depth %u\n",pixel.depth);
          //printf("C-check: %zd %lu : %zd %zd => %f %f %f %f %u %s\n",xpixel,width,x,y,pixels[x][y].red,pixels[x][y].green,pixels[x][y].blue,pixels[x][y].alpha,pixel.colorspace,PixelGetColorAsString(pixelWands[x]));
        }
    }
  iterator=DestroyPixelIterator(iterator);
  //	MagickWandTerminus();
  //printf("Size %zd\n",width);
  printf("Processed %s!\n %f\n",file,pixels[0][0].red);
  return pixels;
}

  /*
   *Main method test-runs and returns values.
   /*
   /*
int main(int argc, char *argv[])
{
  printf("Hello, c-library!");
  printf("Storage size for int : %ld %s %s \n", sizeof(int),argv[0],argv[1]);
  size_t pWidth = 0;
  size_t pHeight=0;
  Pixel** outValue = pixelWandGet(argv[1],&pWidth,&pHeight);
  printf("You're out!");
  printf("You're out! %zd %zd %f %f",pWidth,pHeight,outValue[0][0].red,outValue[0][0].blue);
  return 0;
}*/
