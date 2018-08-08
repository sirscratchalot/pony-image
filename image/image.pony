class Image
let _originalString:String val
new create( imageData:String) =>
    _originalString = imageData

fun string():String => _originalString.clone()

class Pixel 

    let _x:U32 val
    let _y:U32 val

    new create(pixelLine:String) =>
        _x=0
        _y=0
        let split = pixelLine.split_by(" ")
         
