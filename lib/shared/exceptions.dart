import 'errors.dart';

class LocalDatabaseFailureException implements Exception {
  LocalDatabaseError localDatabaseError;
  String message;

  LocalDatabaseFailureException(this.localDatabaseError, {this.message = ""});
}
