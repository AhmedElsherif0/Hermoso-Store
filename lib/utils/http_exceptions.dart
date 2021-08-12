
class HttpExceptions implements Exception {

  final String message ;

  HttpExceptions(this.message);

  @override
  String toString() {
    return message ;
  }

 String authHandlerExceptions(var error){
    var errorMessage = 'Authentication Error' ;
    if(error.message.contains('EMAIL_EXISTS') == true){
      errorMessage = 'Email is already Exist';
    }else if (error.message.contains('INVALID_EMAIL') == true){
      errorMessage= 'Email Not Valid';
    }else if (error.message.contains('WEAK_PASSWORD') == true){
      errorMessage = 'Password IS Weak';
    }else if (error.message.contains('EMAIL_NOT_FOUND') == true){
      errorMessage = 'Could\'nt Find this Email';
    }else if(error.message.contains('INVALID_PASSWORD') ==true){
      errorMessage ='Password is InValid';
    }
    return errorMessage ;
  }
}