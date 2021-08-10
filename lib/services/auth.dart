import 'package:environ/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromUserCredential(User? user) => UserModel(uid: user!.uid);

  Stream<UserModel> get user =>
      _auth.authStateChanges().map(_userFromUserCredential);

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      return _userFromUserCredential(user);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      return _userFromUserCredential(user);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
