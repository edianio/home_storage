class UserApp {
  final String? id;
  final String name;
  final String email;
  final String? token;

  UserApp({
    this.id,
    required this.name,
    required this.email,
    this.token,
  });
}
