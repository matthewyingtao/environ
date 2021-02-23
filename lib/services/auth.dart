import 'package:brewcrew/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromUserCredential(User user) {
    return UserModel(uid: user.uid);
  }

  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromUserCredential(user));
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      if (user != null) {
        return _userFromUserCredential(user);
      } else {
        return user;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
