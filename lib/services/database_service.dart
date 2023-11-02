import 'package:familyfridge/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<FirebaseUser> getUser(String email) async {
    await for (var snapshot in _db.collection('users_data').snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()['email'] == email) {
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
        if (message.data()['familyID'] == user.familyID) {
          for (String friendEmail in message.data()['membersEmails']) {
            FirebaseUser friend = await getUser(friendEmail);
            friendsList.add(friend);
          }
          return friendsList;
        }
      }
    }
    return friendsList;
  }

  Future<void> setUserDataFromGoogle(User user) async {
    var uuid = const Uuid();
    String familyID = uuid.v4().substring(0, 6);
    var doc = await _db.collection('users_data').doc(user.email).get();
    if (doc.exists) return;
    await _db.collection('users_data').doc(user.email).set({
      'displayName': user.displayName,
      'email': user.email,
      'familyID': familyID,
      'photoURL': user.photoURL
    });
    await _db.collection('families').doc(familyID).set({
      'food': {},
      'familyID': familyID,
      'membersEmails': [user.email]
    });
  }

  Future<dynamic> getDataFromFirestore(String collection, String documentID, String field) async {
    await for (var snapshot in _db.collection(collection).snapshots()) {
      for (var message in snapshot.docs) {
        if(message.id == documentID){
          return message.data()[field];
        }
      }
    }
  }

  void updateDatabase() {
    _db = FirebaseFirestore.instance;
  }

  Future<void> insertUserData(String email, String field, String value) async{
    await _db.collection('users_data').doc(email).set({
      field:value
    }, SetOptions(merge : true));
  }

  Future<void> addUserToFamily(String userEmail, String newFamilyID, String oldFamilyID) async {
    List<dynamic> newMembersEmails = await getDataFromFirestore('families', newFamilyID, 'membersEmails');
    List<dynamic> oldMembersEmails = await getDataFromFirestore('families', newFamilyID, 'membersEmails');
    newMembersEmails.add(userEmail);
    if(oldMembersEmails.length == 1){
      _db.collection('families').doc(oldFamilyID).delete();
    }
    await _db.collection('families').doc(newFamilyID).set({'membersEmails':newMembersEmails}, SetOptions(merge : true));
  }
}
