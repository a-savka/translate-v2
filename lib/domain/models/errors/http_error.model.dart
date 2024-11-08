import 'package:translate_1/domain/models/errors/generic_error.model.dart';

class HttpError extends GenericError {
  HttpError({
    required super.code,
    required super.message,
    super.details,
    super.stackTrace,
  });
}
