import 'package:environ/models/brew.dart';
import 'package:environ/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService({required this.uid});

  final String uid;

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async =>
      brewCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) => UserData(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength'],
      );

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) => snapshot.docs
      .map((doc) => Brew(
          name: doc['name'] ?? '',
          sugars: doc['sugars'] ?? '',
          strength: doc['strength'] ?? 0))
      .toList();

  Stream<List<Brew>> get brews =>
      brewCollection.snapshots().map(_brewListFromSnapshot);

  Stream<UserData> get userData =>
      brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
}
