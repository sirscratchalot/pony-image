use "collections"
use "lib:MagickWand-6.Q16"
use "path:./c"
use "lib:pixelwand"
use "inspect"
type TuplePixel is (F64,F64,F64,F64,F64)
 
      
actor ReadPixelWandLib
  new create(file:String val,handler:ImageHandler tag) =>
    //Retrieve C 
    let actualPixels = recover iso Array[Array[Pixel val] val] end

    var width:USize = 0
    var height:USize = 0

    var cPointer : Pointer[Pointer[TuplePixel]] = @pixelWandGet[Pointer[Pointer[TuplePixel]]](
        file.cstring(),addressof width,addressof height)
    handler.handleError("Resolution "+width.string()+" : "+height.string())

    //Allocate 2D pixel array
    let arrayOne = Array[Pointer[TuplePixel]].from_cpointer(cPointer,width,width)
    for pointer in arrayOne.values() do
      let array =pixelFromTuple(Array[TuplePixel].from_cpointer(pointer,height,height))
      actualPixels.push(array)
    end
    //Proceed to build image
    let valImageFinal  = recover val Image(file, (recover val consume actualPixels end),height, width) end
    handler.handleError("Done with image: "+file) 
    handler.handleImage(valImageFinal)

  fun pixelFromTuple(tuples:Array[TuplePixel val]):Array[Pixel val] val =>
    let pixelArray = recover iso Array[Pixel val] end
    for tp in tuples.values() do
      let pixel = recover val Pixel(tp) end
      pixelArray.push(pixel)
    end
    recover val consume pixelArray end
