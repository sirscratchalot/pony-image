use "collections"
class Image
  let imageName:String
  let pixels:Array[Array[Pixel val] val] val
  let height:USize
  let width:USize 
  let average:Pixel
  

  new create(file:String,inPixels:Array[Array[Pixel val ]val ] val,inHeight:USize,inWidth:USize) =>
    imageName = file
    pixels = inPixels
    height= inHeight
    width = inWidth
    average=Pixel.fromRaw(-99,-99,-99,-99,-99)

  new calculateAverage(img:Image,averagePixel:Pixel) =>
    imageName = img.imageName
    width = img.width
    height = img.height
    pixels = img.pixels
    average= averagePixel

  fun string():String => imageName.clone()
  /*
  Calculate average color of the image and return the value as a pixel.
  */


class Pixel 

  let _red:F64 val
  let _green:F64 val
  let _blue:F64 val
  let _alpha:F64 val
  let _depth:F64 val
  
  fun string():String =>
      ("RGBA ("+_red.string()+", "+_green.string()+", "+_blue.string()+", "+_alpha.string())+") "+_depth.string()+" bit depth"
  fun string8bit():String =>
    let factor = _get8BitFactor()
    "RGBA ("+(_red/factor).string()+", "+
             (_green/factor).string()+", "+(_blue/factor).string()+", "+(_alpha/factor).string()+")"

  fun _get8BitFactor():F64 =>
   (F64(2).pow(_depth)-1)/255

  new fromRaw(red:F64,green:F64,blue:F64,alpha:F64,depth:F64) =>
    _red=red
    _blue=blue
    _green=green
    _alpha=alpha
    _depth=depth

  new create(inPixel:TuplePixel) =>
    _red=inPixel._1
    _blue=inPixel._2
    _green=inPixel._3
    _alpha=inPixel._4
    _depth=inPixel._5

  fun getAlpha():F64 val=> 
    _alpha
  fun getRed():F64 val=> 
    _red
  fun getBlue():F64 val=> 
    _blue
  fun getGreen():F64 val=> 
    _green
  fun getDepth():F64 val=> 
    _depth
    
    
    
