
#include <wand/magick-wand.h>
#include <stdio.h>
#include <limits.h>

void test_wand(void);

int main()
{
    printf("Hello, World!");
    printf("Storage size for int : %d \n", sizeof(int));
    test_wand();
    return 0;
}
void test_wand(void)
{
    char* blob = NULL;
    size_t size=0;
    MagickWand *mw = NULL;
    MagickWandGenesis();
    /* Create a wand */
    mw = NewMagickWand();
    /* Read the input image */
    MagickReadImage(mw,"etimo.png");
    MagickSetImageFormat(mw,"txt");
//    MagickWandGetImageStatistics(mw);
    /* write it */
    MagickWriteImage(mw,"logo.jpg");

    /* Tidy up */
    if(mw) mw = DestroyMagickWand(mw);

    MagickWandTerminus();
}

