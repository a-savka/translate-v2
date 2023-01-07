class GenericError {
  final int code;
  final String message;
  final String? details;
  final StackTrace? stackTrace;
  GenericError({
    required this.code,
    required this.message,
    this.details,
    this.stackTrace,
  });
}
