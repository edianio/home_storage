import 'package:home_storage/src/domain/user/repository/user_app_repository.dart';

class ForgotPassword {
  final UserAppRepository repository;

  const ForgotPassword(this.repository);

  Future<void> call(String email) => repository.forgotPassword(email);
}
