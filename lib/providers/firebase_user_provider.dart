import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/models/user_model.dart';
import 'package:familyfridge/services/database_service.dart';

class FirebaseUserProvider extends ChangeNotifier {
  FirebaseUser _user = FirebaseUser();
  FirebaseUser get user => _user;

  Future<void> setUserData(String email) async{
    DatabaseService db = DatabaseService();
    FirebaseUser user = await db.getUser(email);
    _user = user;
  }

  void changeFamilyID(String familyID){
    _user.familyID = familyID;
  }
}