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
      'membersEmails': [user.email],
      'shoppingLists': [
        {
          'title': 'Creamy Garlic Chicken Pasta',
          'list': {
            'Pasta': false,
            'Chicken breast': false,
            'Olive oil': false,
            'Butter': false,
            'Garlic': false,
            'Tomatoes': false,
            'Spinach': false,
            'Heavy cream': false,
            'Parmesan cheese': false,
          },
        }
      ]
    });
  }

  Future<dynamic> getDataFromFirestore(
      String collection, String documentID, String field) async {
    updateDatabase();
    await for (var snapshot in _db.collection(collection).snapshots()) {
      for (var message in snapshot.docs) {
        if (message.id == documentID) {
          return message.data()[field];
        }
      }
    }
  }

  void updateDatabase() {
    _db = FirebaseFirestore.instance;
  }

  Future<void> insertUserData(String email, String field, String value) async {
    await _db
        .collection('users_data')
        .doc(email)
        .set({field: value}, SetOptions(merge: true));
  }

  Future<void> addFoodToFridge(
      String familyID, Map<String, Map<String, dynamic>> foodInfo) async {
    Map<String, dynamic> foodInFridge =
        await getDataFromFirestore('families', familyID, 'food');
    foodInfo.forEach((key, value) {
      foodInFridge[key] == null
          ? foodInFridge[key] = value
          : foodInFridge[key]['quantity'] += foodInfo[key]!['quantity'];
    });
    await _db
        .collection('families')
        .doc(familyID)
        .set({'food': foodInFridge}, SetOptions(merge: true));
  }

  Future<void> addUserToFamily(
      String userEmail, String newFamilyID, String oldFamilyID) async {
    List<dynamic> newMembersEmails =
        await getDataFromFirestore('families', newFamilyID, 'membersEmails');
    List<dynamic> oldMembersEmails =
        await getDataFromFirestore('families', newFamilyID, 'membersEmails');
    newMembersEmails.add(userEmail);
    if (oldMembersEmails.length == 1) {
      _db.collection('families').doc(oldFamilyID).delete();
    }
    await _db
        .collection('families')
        .doc(newFamilyID)
        .set({'membersEmails': newMembersEmails}, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamFamilyData(
      String familyID) {
    return _db.collection('families').doc(familyID).snapshots();
  }

  Future<void> addSingleFoodToFridge(String familyID, String foodName) async {
    Map<String, dynamic> foodInFridge =
        await getDataFromFirestore('families', familyID, 'food');
    foodInFridge[foodName]['quantity'] += 1;
    await _db
        .collection('families')
        .doc(familyID)
        .set({'food': foodInFridge}, SetOptions(merge: true));
  }

  Future<void> removeSingleFoodToFridge(
      String familyID, String foodName) async {
    Map<String, dynamic> foodInFridge =
        await getDataFromFirestore('families', familyID, 'food');
    if (foodInFridge[foodName]['quantity'] == 1) {
      foodInFridge.remove(foodName);
    } else {
      foodInFridge[foodName]['quantity'] -= 1;
    }
    ;
    await _db.collection('families').doc(familyID).update({
      'food': foodInFridge,
    });
  }

  Future<void> addBlankShoppingList(String familyID, String title) async{
    List<dynamic> shoppingLists = await getDataFromFirestore('families', familyID, 'shoppingLists');
    shoppingLists.add({
      'title':title,
      'list':{}
    });
    await _db.collection('families').doc(familyID).update({
      'shoppingLists':shoppingLists
    });
  }

  Future<void> changeShoppingListProductStatus(String familyID, String productName, int index) async{
    List<dynamic> shoppingLists = await getDataFromFirestore('families', familyID, 'shoppingLists');
    shoppingLists[index]['list'][productName] = !shoppingLists[index]['list'][productName];
    print(shoppingLists);
    await _db.collection('families').doc(familyID).update({
      'shoppingLists':shoppingLists
    });
  }

  Future<void> addNewProductToShoppingList(String familyID, String productName, int index) async{
    List<dynamic> shoppingLists = await getDataFromFirestore('families', familyID, 'shoppingLists');
    shoppingLists[index]['list'][productName] = false;
    await _db.collection('families').doc(familyID).update({
      'shoppingLists':shoppingLists
    });
  }
}
