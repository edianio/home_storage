import 'package:home_storage/src/domain/user/entities/auth_params.dart';
import 'package:home_storage/src/domain/user/entities/user_app.dart';
import 'package:home_storage/src/domain/user/repository/user_app_repository.dart';

class Login {
  final UserAppRepository repository;

  const Login(this.repository);

  Future<UserApp> call(AuthParams params) => repository.login(params);
}
