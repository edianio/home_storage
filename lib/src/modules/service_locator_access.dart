import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_storage/src/data/user/data_source/user_app_data_source.dart';
import 'package:home_storage/src/data/user/rempository/user_app_repository_impl.dart';
import 'package:home_storage/src/domain/user/repository/user_app_repository.dart';
import 'package:home_storage/src/domain/user/use_cases/forgot_password.dart';
import 'package:home_storage/src/domain/user/use_cases/get_current_user.dart';
import 'package:home_storage/src/domain/user/use_cases/login.dart';
import 'package:home_storage/src/domain/user/use_cases/login_with_google.dart';
import 'package:home_storage/src/domain/user/use_cases/logout.dart';
import 'package:home_storage/src/domain/user/use_cases/sign_up.dart';
import 'package:home_storage/src/domain/user/use_cases/update_user.dart';
import 'package:home_storage/src/external/user/user_app_data_source_firebase.dart';
import 'package:home_storage/src/modules/service_locator_setup.dart';

void serviceLocatorAccess() {
  // DATA SOURCE
  getIt.registerLazySingleton<UserAppDataSource>(() => UserAppDataSourceFirebase(getIt<FirebaseFirestore>(), getIt<FirebaseAuth>()));
  // REPOSITORY
  getIt.registerLazySingleton<UserAppRepository>(() => UserAppRepositoryImpl(getIt<UserAppDataSource>()));
  // USE CASES
  getIt.registerLazySingleton<Login>(() => Login(getIt<UserAppRepository>()));
  getIt.registerLazySingleton<SignUp>(() => SignUp(getIt<UserAppRepository>()));
  getIt.registerLazySingleton<Logout>(() => Logout(getIt<UserAppRepository>()));
  getIt.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser(getIt<UserAppRepository>()));
  getIt.registerLazySingleton<UpdateUser>(() => UpdateUser(getIt<UserAppRepository>()));
  getIt.registerLazySingleton<ForgotPassword>(() => ForgotPassword(getIt<UserAppRepository>()));
  getIt.registerLazySingleton<LoginWithGoogle>(() => LoginWithGoogle(getIt<UserAppRepository>()));
}
