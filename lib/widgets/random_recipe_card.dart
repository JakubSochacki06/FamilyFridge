import 'package:familyfridge/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/data/food.dart';

class RandomRecipeCard extends StatelessWidget {
  final String title;
  final String imageURL;
  RandomRecipeCard(
      {required this.title, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF8FCFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Color(0xFFDFF1FF))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            backgroundImage:
                NetworkImage(imageURL),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
