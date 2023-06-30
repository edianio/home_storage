import 'package:home_storage/src/domain/user/entities/user_app.dart';
import 'package:home_storage/src/domain/user/repository/user_app_repository.dart';

class UpdateUser {
  final UserAppRepository repository;

  const UpdateUser(this.repository);

  Future<void> call(UserApp user) => repository.updateUser(user);
}
