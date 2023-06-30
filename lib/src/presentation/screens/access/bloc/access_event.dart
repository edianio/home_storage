import 'package:home_storage/src/domain/user/entities/auth_params.dart';
import 'package:home_storage/src/domain/user/entities/user_app.dart';

sealed class AccessEvent {}

class LoginAccessEvent implements AccessEvent {
  final AuthParams authParams;

  LoginAccessEvent({required this.authParams});
}

class SignUpAccessEvent implements AccessEvent {
  final UserApp user;
  final AuthParams authParams;

  const SignUpAccessEvent({required this.user, required this.authParams});
}

class LogoutAccessEvent implements AccessEvent {}

class ForgotPasswordAccessEvent implements AccessEvent {
  final String email;

  const ForgotPasswordAccessEvent({required this.email});
}

class LoginWithGoogleAccessEvent implements AccessEvent {}

class UpdateUserAccessEvent implements AccessEvent {
  final UserApp user;

  const UpdateUserAccessEvent({required this.user});
}

class GetCurrentUserAccessEvent implements AccessEvent {}
