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
            imageEndings.contains(file.substring(size-4,size).lower(),{(k,l):Bool => k == l})
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
        @MagickWandTerminus[None]() //terminate MagickWand environment.
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
            ReadImage(file,
             HandleImage({(image:Image) =>  
                _env.out.print("I got some image!"+image.string().substring(0,300))
             },
               {(errorMessage:String) => _env.out.print("Error from image read: "+errorMessage)}  
             ))
            end

        be errorMessage(errorText:String) => _env.out.print(errorText)

        
