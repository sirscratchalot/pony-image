actor HandleImage
    let _returnLambda:{(Image)} val
    let _errorLambda:{(String)} val
    new create(returnLambda:{(Image)} val,errorLambda:{(String)} val) =>
        _returnLambda = returnLambda
        _errorLambda = errorLambda
    be handleImage(file:String, converted:String) =>
        let image:Image = Image(converted)
        _returnLambda(image)
    be handleError(errorMessage:String) => 
        _errorLambda(errorMessage)
        
