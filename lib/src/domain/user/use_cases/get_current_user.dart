import 'package:home_storage/src/domain/user/entities/user_app.dart';
import 'package:home_storage/src/domain/user/repository/user_app_repository.dart';

class GetCurrentUser {
  final UserAppRepository repository;

  const GetCurrentUser(this.repository);

  Stream<UserApp?> call() => repository.getCurrentUser();
}
