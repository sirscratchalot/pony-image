actor CreateActor 
    new create() => 
       let array = Array[Array[String]]() 
       let test = TestClass(array)
class TestClass
    let _array:Array[Array[String]]
    new create(array:Array[Array[String]]) =>
        _array=array
