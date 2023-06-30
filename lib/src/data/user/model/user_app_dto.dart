import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_storage/src/domain/user/entities/user_app.dart';

class UserAppDto {
  final String? id;
  final String name;
  final String email;
  final String? token;

  UserAppDto({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  factory UserAppDto.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) => UserAppDto(
        id: doc.id,
        name: doc['name'],
        email: doc['email'],
        token: doc['token'],
      );

  factory UserAppDto.fromJson(Map<String, dynamic> json) => UserAppDto(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'token': token,
      };

  /// This method is used to convert the data from the database to the firebase
  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'token': token,
      };

  UserApp toEntity() => UserApp(
        id: id,
        name: name,
        email: email,
        token: token,
      );

  factory UserAppDto.fromEntity(UserApp user) => UserAppDto(
        id: user.id,
        name: user.name,
        email: user.email,
        token: user.token,
      );
}
