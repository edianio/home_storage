import 'package:bloc_test/bloc_test.dart';
import 'package:home_storage/src/domain/user/entities/auth_params.dart';
import 'package:home_storage/src/domain/user/entities/user_app.dart';
import 'package:home_storage/src/domain/user/use_cases/forgot_password.dart';
import 'package:home_storage/src/domain/user/use_cases/get_current_user.dart';
import 'package:home_storage/src/domain/user/use_cases/login.dart';
import 'package:home_storage/src/domain/user/use_cases/login_with_google.dart';
import 'package:home_storage/src/domain/user/use_cases/logout.dart';
import 'package:home_storage/src/domain/user/use_cases/sign_up.dart';
import 'package:home_storage/src/domain/user/use_cases/update_user.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_bloc.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_event.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLogin extends Mock implements Login {}

class _MockSignUp extends Mock implements SignUp {}

class _MockLoginWithGoogle extends Mock implements LoginWithGoogle {}

class _MockLogout extends Mock implements Logout {}

class _MockGetCurrentUser extends Mock implements GetCurrentUser {}

class _MockUpdateUser extends Mock implements UpdateUser {}

class _MockForgotPassword extends Mock implements ForgotPassword {}

void main() {
  final UserApp userApp = UserApp(
    id: 'abCD1234',
    name: 'Kakarotto',
    email: 'goku@db.com',
    token: 'frDseGbH52Lt7d',
  );
  final AuthParams authParams = AuthParams(
    email: 'email',
    password: 'password',
  );
  final Exception exception = Exception('Error');

  AccessBloc getBloc({
    Logout? logout,
    Login? login,
    SignUp? signUp,
    LoginWithGoogle? loginWithGoogle,
    GetCurrentUser? getCurrentUser,
    UpdateUser? updateUser,
    ForgotPassword? forgotPassword,
  }) {
    return AccessBloc(
      forgotPassword: forgotPassword ?? _MockForgotPassword(),
      login: login ?? _MockLogin(),
      signUp: signUp ?? _MockSignUp(),
      loginWithGoogle: loginWithGoogle ?? _MockLoginWithGoogle(),
      logout: logout ?? _MockLogout(),
      getCurrentUser: getCurrentUser ?? _MockGetCurrentUser(),
      updateUser: updateUser ?? _MockUpdateUser(),
    );
  }

  setUp(() {
    registerFallbackValue(AuthParams(email: '', password: ''));
  });

  group('Login test', () {
    blocTest<AccessBloc, AccessState>(
      'should emit AccessLoadingState and AccessLoadedState when LoginAccessEvent is added',
      build: () {
        final login = _MockLogin();
        when(() => login(any())).thenAnswer((_) async => userApp);
        return getBloc(login: login);
      },
      act: (bloc) => bloc.add(LoginAccessEvent(authParams: authParams)),
      expect: () => [
        isA<AccessLoadingState>(),
        predicate<AccessLoadedState>((state) => state.user == userApp),
      ],
    );

    blocTest<AccessBloc, AccessState>(
      'should emit AccessLoadingState and AccessErrorState when LoginAccessEvent is added and throws an exception',
      build: () {
        final login = _MockLogin();
        when(() => login(any())).thenThrow(exception);
        return getBloc(login: login);
      },
      act: (bloc) => bloc.add(LoginAccessEvent(authParams: authParams)),
      expect: () => [
        isA<AccessLoadingState>(),
        predicate<AccessErrorState>((state) => state.message == exception.toString()),
      ],
    );
  });
}
