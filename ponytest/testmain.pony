use "ponytest"
use "../image"
use ".."

actor Main 
  new create(env: Env) =>
   runStringToNumber()
   // runFilterChecks()
    
  fun runFilterChecks() => 
    let imageEndings:Array[String val] val = [".jpg";".png";".bmp";".gif"]
    env.out.print("String in Array "+imageEndings.contains(".png").string())
    //Prints: String in Array true
    let endPng:String val = ".png"
    env.out.print("Let in Array "+imageEndings.contains(".png").string())
    //Prints: Let in Array true
    let imageName ="testing.png"
    let size=imageName.size().isize()
    let ending:String val = recover val imageName.substring(size-4, size).lower() end
    env.out.print("Ending "+ending.clone()+" "+ending.size().isize().string()+" "+imageEndings.contains(ending,{(l,j):Bool=>l == j}).string())
    //BUT, this prints: Ending .png 4 false
    //What's going on with substring?
     

   fun runStringToNumber() => 
