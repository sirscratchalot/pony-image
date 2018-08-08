actor HandleImage
    let _returnLambda:{(Image val)} val
    let _errorLambda:{(String val)} val
    new create(returnLambda:{(Image val)} val,errorLambda:{(String val)} val) =>
        _errorLambda = errorLambda
        _returnLambda = returnLambda
    be handleImage(image:Image val) =>
        _returnLambda(image)
    be handleError(errorMessage:String) => 
        _errorLambda(errorMessage)
       
