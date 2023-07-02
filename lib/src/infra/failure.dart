import 'package:home_storage/src/infra/failure_type.dart';

class Failure {
  final FailureType type;
  final String message;

  const Failure(this.type, this.message);

  @override
  String toString() => 'Failure: $message';
}
