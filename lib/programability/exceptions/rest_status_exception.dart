class RestStatusException implements Exception {
  final int statusCode;
  final String exceptionText;

  RestStatusException(
    this.statusCode,
    this.exceptionText,
  ) : super();

  @override
  String toString() {
    return 'Unexpected http return status: ' +
        this.statusCode.toString() +
        ', ' +
        this.exceptionText;
  }
}
