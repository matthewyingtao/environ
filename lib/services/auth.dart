import 'package:brewcrew/models/user_model.dart';
import 'package:brewcrew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromUserCredential(User user) {
    return UserModel(uid: user.uid);
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromUserCredential);
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
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromUserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData("0", "new crew member", 100);
      return _userFromUserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
