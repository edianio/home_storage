import 'package:home_storage/src/domain/user/entities/user_app.dart';

sealed class AccessState {}

class AccessLoadingState implements AccessState {}

class AccessLoadedState implements AccessState {
  final UserApp? user;

  const AccessLoadedState({this.user});
}

class AccessErrorState implements AccessState {
  final String message;

  const AccessErrorState({required this.message});
}
