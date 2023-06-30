import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_storage/src/data/user/data_source/user_app_data_source.dart';
import 'package:home_storage/src/data/user/model/user_app_dto.dart';
import 'package:home_storage/src/domain/user/entities/auth_params.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAppDataSourceFirebase implements UserAppDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  const UserAppDataSourceFirebase(this.firestore, this.auth);

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Stream<UserAppDto?> getCurrentUser() async* {
    final user = auth.currentUser;
    if (user != null) {
      final document = await _getCollectionReference().doc(user.uid).get();
      yield UserAppDto.fromDocument(document as DocumentSnapshot<Map<String, dynamic>>);
    }
    yield null;
  }

  @override
  Future<UserAppDto> login(AuthParams params) async {
    final userCredential = await auth.signInWithEmailAndPassword(email: params.email, password: params.password);
    final document = await _getCollectionReference().doc(userCredential.user!.uid).get();
    return UserAppDto.fromDocument(document as DocumentSnapshot<Map<String, dynamic>>);
  }

  @override
  Future<UserAppDto> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    UserAppDto user = UserAppDto(name: '', email: '', id: null);

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);
      user = UserAppDto(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
        token: userCredential.user!.refreshToken!,
      );

      await _getCollectionReference().doc(user.id.toString()).set(user.toMap());
    }
    return user;
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<UserAppDto> signUp(UserAppDto user, AuthParams authParams) async {
    final userCredential = await auth.createUserWithEmailAndPassword(email: authParams.email, password: authParams.password);
    final userDto = UserAppDto(
      id: userCredential.user!.uid,
      name: user.name,
      email: user.email,
      token: user.token,
    );
    await _getCollectionReference().doc(userDto.id.toString()).set(userDto.toMap());
    return userDto;
  }

  @override
  Future<void> updateUser(UserAppDto user) async {
    await _getCollectionReference().doc(user.id.toString()).update(user.toMap());
  }

  CollectionReference _getCollectionReference() {
    return firestore.collection('users');
  }
}
