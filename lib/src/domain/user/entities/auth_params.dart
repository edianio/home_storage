class AuthParams {
  final String email;
  final String password;

  AuthParams({required this.email, required this.password});

  AuthParams copyWith({
    String? email,
    String? password,
  }) {
    return AuthParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
