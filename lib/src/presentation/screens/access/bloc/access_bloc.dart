import 'package:home_storage/src/domain/user/use_cases/forgot_password.dart';
import 'package:home_storage/src/domain/user/use_cases/get_current_user.dart';
import 'package:home_storage/src/domain/user/use_cases/login.dart';
import 'package:home_storage/src/domain/user/use_cases/login_with_google.dart';
import 'package:home_storage/src/domain/user/use_cases/logout.dart';
import 'package:home_storage/src/domain/user/use_cases/sign_up.dart';
import 'package:home_storage/src/domain/user/use_cases/update_user.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_event.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  final ForgotPassword _forgotPassword;
  final Login _login;
  final SignUp _signUp;
  final LoginWithGoogle _loginWithGoogle;
  final GetCurrentUser _getCurrentUser;
  final Logout _logout;

  ///stay here by testing the app
  final UpdateUser _updateUser;

  AccessBloc({
    required ForgotPassword forgotPassword,
    required Login login,
    required SignUp signUp,
    required LoginWithGoogle loginWithGoogle,
    required GetCurrentUser getCurrentUser,
    required Logout logout,
    required UpdateUser updateUser,
  })  : _forgotPassword = forgotPassword,
        _login = login,
        _signUp = signUp,
        _loginWithGoogle = loginWithGoogle,
        _getCurrentUser = getCurrentUser,
        _logout = logout,
        _updateUser = updateUser,
        super(const AccessLoadedState()) {
    on<LoginAccessEvent>(_loginOnApp);
    on<SignUpAccessEvent>(_signUpOnApp);
    on<LoginWithGoogleAccessEvent>(_loginWithGoogleOnApp);
    on<LogoutAccessEvent>(_logoutOnApp);
    on<GetCurrentUserAccessEvent>(_getCurrentUserOnApp);
    on<ForgotPasswordAccessEvent>(_forgotPasswordOnApp);
    on<UpdateUserAccessEvent>(_updateUserOnApp);
  }

  Future<void> _loginOnApp(LoginAccessEvent event, Emitter emit) async {
    emit(AccessLoadingState());
    try {
      final user = await _login(event.authParams);
      emit(AccessLoadedState(user: user));
    } catch (e) {
      emit(AccessErrorState(message: e.toString()));
    }
  }

  Future<void> _signUpOnApp(SignUpAccessEvent event, Emitter emit) async {
    emit(AccessLoadingState());
    try {
      final user = await _signUp(event.user, event.authParams);
      emit(AccessLoadedState(user: user));
    } catch (e) {
      emit(AccessErrorState(message: e.toString()));
    }
  }

  Future<void> _loginWithGoogleOnApp(LoginWithGoogleAccessEvent event, Emitter emit) async {
    emit(AccessLoadingState());
    try {
      final user = await _loginWithGoogle();
      emit(AccessLoadedState(user: user));
    } catch (e) {
      emit(AccessErrorState(message: e.toString()));
    }
  }

  Future<void> _logoutOnApp(LogoutAccessEvent event, Emitter emit) async {
    emit(AccessLoadingState());
    try {
      await _logout();
      emit(const AccessLoadedState());
    } catch (e) {
      emit(AccessErrorState(message: e.toString()));
    }
  }

  Future<void> _getCurrentUserOnApp(GetCurrentUserAccessEvent event, Emitter emit) async {
    await emit.onEach(
      _getCurrentUser(),
      onData: (data) => emit(AccessLoadedState(user: data)),
      onError: (error, stack) => emit(AccessErrorState(message: error.toString())),
    );
  }

  Future<void> _forgotPasswordOnApp(ForgotPasswordAccessEvent event, Emitter emit) async {
    emit(AccessLoadingState());
    try {
      await _forgotPassword(event.email);
      emit(const AccessLoadedState());
    } catch (e) {
      emit(AccessErrorState(message: e.toString()));
    }
  }

  Future<void> _updateUserOnApp(UpdateUserAccessEvent event, Emitter emit) async {
    try {
      await _updateUser(event.user);
      emit(AccessLoadedState(user: event.user));
    } catch (e) {
      emit(AccessErrorState(message: e.toString()));
    }
  }
}
