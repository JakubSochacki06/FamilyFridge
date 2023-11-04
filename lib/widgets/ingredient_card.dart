import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  final String name;
  final double calories;
  final double carbohydrates;
  final double fats;
  final double proteins;
  final bool isActive;
  final onTap;

  IngredientCard({required this.name, required this.calories, required this.carbohydrates, required this.fats, required this.proteins, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: isActive? Color(0xFFDFF1FF) : Color(0xFFF8FCFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isActive? Color(0xFF1f7c9e) : Color(0xFFDFF1FF))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 55,
              backgroundImage: AssetImage('assets/food/${name.toLowerCase()}.png'),
            ),
            SizedBox(height: 5,),
            Text(name, style: TextStyle(fontSize: 20),),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Kcal'),
                    Text(calories.toString())
                  ],
                ),
                Column(
                  children: [
                    Text('Carbs'),
                    Text(carbohydrates.toString())
                  ],
                ),
                Column(
                  children: [
                    Text('Fats'),
                    Text(fats.toString())
                  ],
                ),
                Column(
                  children: [
                    Text('Proteins'),
                    Text(proteins.toString())
                  ],
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
