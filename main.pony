use "collections"
use "inspect"
use "lib:MagickWand-6.Q16"
use "./filactors"
use "./image"
actor Main
  let _env:Env
  let imageEndings:Array[String] val = [".jpg";".png";".bmp";".gif"]
  let _filter:{(String):Bool} val = {(file:String):Bool => 
  let size = file.size().isize() 
  imageEndings.contains(file.substring(size-4,size).lower(),
  {(k,l):Bool => k == l}) //Predicate function is necessary or check will be for actual object, not equivalency.
  }
  
  new create(env:Env) =>
    _env=env
    try initiateImageRead(env.args(1)?)
      else initiateImageRead(".") end //Read provided argument folder, or current folder.

  be initiateImageRead(directory:String) => 

    _env.out.print("reading images in "+ directory)
    try 
      FileList(directory,_env.root as AmbientAuth,FilterFiles(_filter,_env)) 
    else
      _env.out.print("Error in execution, bad root?")
    end

  fun _final() =>
    @MagickWandTerminus[None]() //terminate MagickWand environment, FFI. 
  be print(message:String) =>
    _env.out.print(message)
    /**
    * Filter files and create a ColorCalculator if file ending.
    */    
actor FilterFiles 
  let _env:Env
  let _filter:{(String):Bool} val
  
  new create(filter:{(String):Bool} val,env:Env) =>
    _env=env
    _filter=filter
    @MagickWandGenesis[None]() //initiate MagickWand environment.    
    
  be foundFile(file:String) =>
    let filtered:Bool = _filter(file)
    _env.out.print("Received "+ file+", passed: "+filtered.string())
    if filtered is true then
      ReadPixelWandLib(file,
      HandleImage({(image:Image val) =>  
      _env.out.print("I got some image!"+image.string().substring(0,300))
      let calculator = CalculateColor(_env)
      calculator.calculateAverage(image)
      },
      {(errorMessage:String) => _env.out.print("Error from image read: "+errorMessage)}  
      ))
    end

  be errorMessage(errorText:String) => _env.out.print(errorText)


actor CalculateColor 
  let _env:Env
  
  new create(env:Env) =>
    _env=env
    
  be calculateAverage(image:Image val) =>
    let average:Pixel = calculateAveragePixel(image,USize(1))
    _env.out.print(image.string()+": Average color "+average.string()+
                                  " Average 8 bit: "+average.string8bit())

  fun calculateAveragePixel(image:Image val, nthPixel:USize):Pixel =>
    var tmpPixel = Pixel.fromRaw(0,0,0,0,0)
    var pixelCount:F64 = 0
    let height = image.height
    let width = image.width
    try
      for x in Range(0,width,nthPixel) do
        for y in Range(0,height) do
          tmpPixel = iteratePixel(tmpPixel,image.pixels(x)?(y)?)
          pixelCount = pixelCount+1
        end
      end
    end

    Pixel.fromRaw(
    tmpPixel.getRed()/pixelCount,
    tmpPixel.getGreen()/pixelCount,
    tmpPixel.getBlue()/pixelCount,
    tmpPixel.getAlpha()/pixelCount,
    tmpPixel.getDepth()
    )
    

  fun iteratePixel(pixelOne:Pixel,pixelTwo:Pixel val):Pixel =>
    Pixel.fromRaw(pixelOne.getRed()+pixelTwo.getRed(),
    pixelOne.getGreen()+pixelTwo.getGreen(),
    pixelOne.getBlue()+pixelTwo.getBlue(),
    pixelOne.getAlpha()+pixelTwo.getAlpha(),
    if pixelTwo.getDepth() > pixelOne.getDepth() then pixelTwo.getDepth() else pixelOne.getDepth() end //Some pixels are 0 depth, could be optimized
    )

    
