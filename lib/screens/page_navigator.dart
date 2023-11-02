import 'package:familyfridge/models/user_model.dart';
import 'package:familyfridge/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'profile_page.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'family_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    Text('test'),
    Text(
      'Likes',
      style: optionStyle,
    ),
    FamilyPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<FirebaseUserProvider>(
          builder: (_, value, child) => FutureBuilder(
            future: value.setUserData(FirebaseAuth.instance.currentUser!.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                return _widgetOptions.elementAt(_selectedIndex);
              } else {
                return const Center(child: Text('Something went Wrong!'));
              }
            },
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Color(0xFFFAC898),
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.kitchen_outlined,
                    text: 'Fridge',
                  ),
                  GButton(
                    icon: Icons.assessment_outlined,
                    text: 'Statistics',
                  ),
                  GButton(
                    icon: Icons.groups_outlined,
                    text: 'Family',
                  ),
                  GButton(
                    icon: Icons.checklist_outlined,
                    text: 'Shopping list',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
