use "collections"
use "lib:MagickWand-6.Q16"
struct _Array
struct _Wand
struct _Iterator
struct _PixelWand
struct _ClassType
struct _AlphaTrait

struct _Pixel
    //var storage_class:_ClassType = _ClassType
    var colorspace:String =""
    var pixelTrait:_AlphaTrait =_AlphaTrait 
   // var alphaTrait:_AlphaTrait= _AlphaTrait
    var fuzz:F64 = 0
    var depth:USize = USize(0) 
    var red:F64 = 0
    var blue:F64 = 0 
    var green:F64 = 0
    var opacity:F64 = 0
    var index:F64 = 0
/*
ClassType 	storage_class
ColorspaceType 	colorspace
MagickBooleanType 	matte
double 	fuzz
size_t 	depth
MagickRealType 	red
MagickRealType 	green
MagickRealType 	blue
MagickRealType 	opacity
MagickRealType 	index

ClassType 	storage_class
ColorspaceType 	colorspace
PixelTrait 	alpha_trait
double 	fuzz
size_t 	depth
MagickSizeType 	count
MagickRealType 	red
MagickRealType 	green
MagickRealType 	blue
MagickRealType 	black
MagickRealType 	alpha
MagickRealType 	index
 */
    
actor ReadPixelWand
    new create(file:String val,handler:ImageHandler tag) =>
            handler.handleError("This is not an error "+file) 
        var wand = @NewMagickWand[_Wand]()
        let readOk = @MagickReadImage[Bool](wand,file.cstring())
        if(readOk == false) then
            handler.handleError("Failed to read image "+file+" "+readOk.string()) 
        return
end
        var iterator=@NewPixelIterator[_Iterator](wand)
        var width:USize = @MagickGetImageWidth[USize](wand)
        var height:USize = @MagickGetImageHeight[USize](wand)
        handler.handleError("Resolution "+" "+width.string()+" : "+height.string())
        var i:USize=0;var j:USize=0

        while j < height do
            j=j+1 
            var pixels:Pointer[_PixelWand] ref = @PixelGetNextIteratorRow[Pointer[_PixelWand] ref](iterator,addressof width)
            let arrayPixels:Array[_PixelWand] = Array[_PixelWand].from_cpointer(pixels,width,width)
            while i<width do
                i=i+1
                var info:_Pixel = _Pixel
                try
                    @PixelGetMagickColor[None](arrayPixels(i)?, addressof info)
                else
                    handler.handleError("Crash!")
                end
            end
            i=0
        end
        // = @MagickGetImageResolution[Bool](wand,addressof width,addressof height)
        let formatOk = @MagickSetImageFormat[Bool](wand,"txt".cstring()) 
        if((readOk != true) or (formatOk != true)) then
            handler.handleError("Failed to format image "+file) 
        else
    

            
        //Retrieve byte buffer in memory and create string
        var len = USize(0) //Return pointer for C method to set size in. Equivalent to size_t in C
        //let bufferPointer:Pointer[U8] ref = @MagickGetImageBlob[Pointer[U8] ref](wand,addressof len)
        //let converted:String ref=  String.from_cpointer(bufferPointer,len)

        //handler.handleImage(file,converted.clone()) //If not cloned, cleaning up MagickWand would kill string.
        
        //@MagickWriteImage[Bool](wand,"txt:-".cstring()) //Writes image to stdout, proof of concept code.
         
            handler.handleError("Done with image: "+file) 
         wand = @DestroyMagickWand[_Wand](wand)

end
