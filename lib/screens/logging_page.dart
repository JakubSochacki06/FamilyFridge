import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/screens/page_navigator.dart';
import 'package:familyfridge/screens/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/services/database_service.dart';

class LoggingPage extends StatefulWidget {
  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            DatabaseService dbs = DatabaseService();
            dbs.setUserDataFromGoogle(FirebaseAuth.instance.currentUser!);
            return PageNavigator();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went Wrong!'));
          } else {
            return const LandingPage();
          }
        },
      ),
    );
  }
}
