import 'package:familyfridge/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/data/food.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String imageURL;
  final String usedIngredientsAmount;
  final String missedInfredientsAmount;
  final onTap;

  RecipeCard(
      {required this.title, required this.imageURL, required this.usedIngredientsAmount, required this.missedInfredientsAmount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              maxLines: 4,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Used ingredients: $usedIngredientsAmount',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Missed ingredients: $missedInfredientsAmount',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
