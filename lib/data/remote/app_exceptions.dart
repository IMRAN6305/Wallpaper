class AppExceptions implements Exception {
  String title;
  String msg;
  AppExceptions({required this.title, required this.msg});

String toErrorMsg(){
  return "$title: $msg";
}

}

class FeatchDataException extends AppExceptions {
  FeatchDataException({required String errormsg})
      : super(title: "Network Error", msg: errormsg);
}

class BadRequestException extends AppExceptions {
  BadRequestException({required String errormsg})
      : super(title: "Bad Request", msg: errormsg);
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required String errormsg})
      : super(title: "Unauthorized", msg: errormsg);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException({required String errormsg})
      : super(title: "Invalid Input", msg: errormsg);
}

class InternalServerErrorException extends AppExceptions {
  InternalServerErrorException({required String errormsg})
      : super(title: "Internal Server Error", msg: errormsg);
}

class NoInternetException extends AppExceptions {
  NoInternetException({required String errormsg})
      : super(title: "No Internet", msg: errormsg);
}

class UnknownException extends AppExceptions {
  UnknownException({required String errormsg})
      : super(title: "Unknown Error", msg: errormsg);
}