import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strength": strength,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()["name"],
      sugars: snapshot.data()["sugars"],
      strength: snapshot.data()["strength"],
    );
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.data()["name"] ?? "",
          sugars: doc.data()["sugars"] ?? "",
          strength: doc.data()["strength"] ?? 0);
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((_brewListFromSnapshot));
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
