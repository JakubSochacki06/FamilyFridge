import 'package:familyfridge/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<FirebaseUser> getUser(String email) async {
    await for (var snapshot in _db.collection('users_data').snapshots()) {
      for (var message in snapshot.docs) {
        if(message.data()['email'] == email) {
          return FirebaseUser.fromMap(message.data());
        }
      }
    }
    return FirebaseUser();
  }

  Future<List<FirebaseUser>> getFriends(FirebaseUser user) async {
    List<FirebaseUser> friendsList = [];
    await for (var snapshot in _db.collection('families').snapshots()) {
      for (var message in snapshot.docs) {
        if(message.data()['familyID'] == user.familyID) {
          for(String friendEmail in message.data()['membersEmails']){
            FirebaseUser friend = await getUser(friendEmail);
            friendsList.add(friend);
          }
          return friendsList;
        }
      }
    }
    return friendsList;
  }

  Future<void> setUserDataFromGoogle(User user) async{
    var uuid = const Uuid();
    String familyID = uuid.v4().substring(0,6);
    var doc = await _db.collection('users_data').doc(user.email).get();
    if(doc.exists) return;
    await _db.collection('users_data').doc(user.email).set({'displayName':user.displayName, 'email':user.email, 'familyID':familyID, 'photoURL':user.photoURL});
    await _db.collection('families').doc(familyID).set({'food':{}, 'familyID':familyID, 'membersEmails':[user.email]});
}
}
