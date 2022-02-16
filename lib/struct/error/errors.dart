abstract class Error {
  String log();
}

class PositionalArgsError extends Error {
  @override
  String log() {
    return 'Contract method calls expect named arguments wrapped in object, '
        'e.g. { argName1: argValue1, argName2: argValue2 }';
  }
}

class ArgumentTypeError extends Error {
  @override
  String log() {
    // TODO: implement log
    throw UnimplementedError();
  }
}

class TypedError extends Error {
  @override
  String log() {
    // TODO: implement log
    throw UnimplementedError();
  }
}

class ErrorContext {
  final String transactionHash;
  ErrorContext(this.transactionHash);
}

