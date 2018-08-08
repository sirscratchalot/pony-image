use "collections"
use "lib:MagickWand-6.Q16"

primitive _MWand //Will use of primitives crash this in a multiple actor situation?
primitive _PixelMWand
primitive _Read

    
actor ReadImage 
    new create(file:String val,handler:ImageHandler tag) =>
        
        @MagickWandGenesis[None]()
        var wand = @NewMagickWand[Pointer[_MWand]]()
        if wand.is_null() then
            return
        end
        let readOk = @MagickReadImage[Bool](wand,file.cstring())
        if(readOk == false) then
            handler.handleError("Failed to read image "+file+" "+readOk.string()) 
        return
end
        let formatOk = @MagickSetImageFormat[Bool](wand,"txt".cstring()) 
        if((readOk != true) or (formatOk != true)) then
            handler.handleError("Failed to format image "+file) 
        else
    

            
        //Retrieve byte buffer in memory and create string
        var len = USize(0) //Return pointer for C method to set size in. Equivalent to size_t in C
        let bufferPointer:Pointer[U8] ref = @MagickGetImageBlob[Pointer[U8] ref](wand,addressof len)
        let converted:String ref=  String.from_cpointer(bufferPointer,len)

//        handler.handleImage(file,converted.clone()) //If not cloned, cleaning up MagickMWand would kill string.
        
        //@MagickWriteImage[Bool](wand,"txt:-".cstring())
         
    if wand.is_null() is false then
         wand = @DestroyMagickWand[Pointer[_MWand]](wand)
    end
end
