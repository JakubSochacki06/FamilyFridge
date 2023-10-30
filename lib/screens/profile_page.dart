import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseUserProvider>(builder: (context, value, child) {
      print(value.user.displayName);
      value.changeName('imie');
      print(value.user.displayName);
      return Column(
        children: [
          Center(
            child: Text(
              'test',
            ),
          ),
        ],
      );
    });
  }
}