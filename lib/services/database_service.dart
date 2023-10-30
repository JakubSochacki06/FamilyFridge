import 'package:familyfridge/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<FirebaseUser> getUser(String email) async {
    var userData = _db.collection("users_data").doc(email);
    Map<String, dynamic> data;
    userData.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
        return FirebaseUser.fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return FirebaseUser();
  }

  Future<void> setUserDataFromGoogle(User user) async{
    await _db.collection('users_data').doc(user.email).set({'displayName':user.displayName, 'email':user.email, 'familyID':null, 'photoURL':user.photoURL});
}
}
