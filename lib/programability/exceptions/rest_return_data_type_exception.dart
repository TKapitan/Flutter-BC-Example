class RestReturnDataTypeException implements Exception {
  final String details;

  RestReturnDataTypeException(
    this.details,
  ) : super();

  @override
  String toString() {
    return 'Unknown data type in REST response: ' + this.details;
  }
}
