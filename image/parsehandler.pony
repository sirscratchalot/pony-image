actor ParseHandler
    let _env:Env
    new create(env:Env) =>
        _env=env
    
    be handleImage(file:String,converted:String) => 
        _env.out.print("Parsed "+file.string()+":\n"+converted.substring(0,100))
        
    
