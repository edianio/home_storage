import 'package:home_storage/src/domain/user/entities/auth_params.dart';
import 'package:home_storage/src/domain/user/entities/user_app.dart';

abstract class UserAppRepository {
  Stream<UserApp?> getCurrentUser();
  Future<UserApp> login(AuthParams params);
  Future<UserApp> signUp(UserApp user, AuthParams authParams);
  Future<UserApp> loginWithGoogle();
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<void> updateUser(UserApp user);
}
