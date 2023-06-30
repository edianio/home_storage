import 'package:home_storage/src/data/user/data_source/user_app_data_source.dart';
import 'package:home_storage/src/data/user/model/user_app_dto.dart';
import 'package:home_storage/src/domain/user/entities/auth_params.dart';
import 'package:home_storage/src/domain/user/entities/user_app.dart';
import 'package:home_storage/src/domain/user/repository/user_app_repository.dart';

class UserAppRepositoryImpl implements UserAppRepository {
  final UserAppDataSource dataSource;

  const UserAppRepositoryImpl(this.dataSource);

  @override
  Future<void> forgotPassword(String email) async {
    await dataSource.forgotPassword(email);
  }

  @override
  Stream<UserApp?> getCurrentUser() => dataSource.getCurrentUser().map((dto) => dto?.toEntity());

  @override
  Future<UserApp> login(AuthParams params) async {
    final dto = await dataSource.login(params);
    return dto.toEntity();
  }

  @override
  Future<UserApp> loginWithGoogle() async {
    final user = await dataSource.loginWithGoogle();
    return user.toEntity();
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }

  @override
  Future<UserApp> signUp(UserApp user, AuthParams authParams) async {
    final dto = await dataSource.signUp(UserAppDto.fromEntity(user), authParams);
    return dto.toEntity();
  }

  @override
  Future<void> updateUser(UserApp user) async {
    await dataSource.updateUser(UserAppDto.fromEntity(user));
  }
}
