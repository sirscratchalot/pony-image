use "files"
use "inspect"
use ".."

actor FileList

let _caps:FileCaps val= recover val FileCaps.>set(FileRead).>set(FileStat) end //Give File objects these permissions. There are so many possible ones.

let _filePath:(FilePath val|None val)
let _reporter:Reporter tag

new create(path:String,auth:AmbientAuth,reporter:Reporter tag) =>
  _reporter = reporter
  _filePath = try FilePath(auth,path,_caps)? else None end
   match _filePath
    | let f:FilePath =>
        _reporter.errorMessage(f.path+" "+f.exists().string().string())

        try iterate(Directory(f)?.entries()?, f.path) else _reporter
            .errorMessage("Could not list files in: "+f.path+" Is this a directory?") 
        end
    |None => _reporter.errorMessage("This isn't a good path!")
end

be iterate(files:Array[String] iso,path:String val) =>
   if(files.size()>0) then
   try
    _reporter.foundFile(path+"/"+files.pop()?.string())
    iterate(consume iso files,path)
   else
        _reporter.errorMessage("Errror handling file list.")
    end
end

