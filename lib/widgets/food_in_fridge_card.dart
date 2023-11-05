import 'package:familyfridge/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/data/food.dart';

class FoodInFridgeCard extends StatelessWidget {
  final String name;
  final String familyID;
  final int quantity;
  final int expMonth;
  final int expYear;

  FoodInFridgeCard(
      {required this.name,
        required this.familyID,
      required this.quantity,
      required this.expMonth,
      required this.expYear});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    final expDate = DateTime(expYear, expMonth);
    final today = DateTime.now();
    final difference = expDate.difference(today).inDays;
    // final difference = 21;
    return Container(
      decoration: BoxDecoration(
          color: difference < 20
              ? difference < 10
                  ? Color(0xFFff6961)
                  : Color(0xFFFAC898)
              : Color(0xFFF8FCFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: difference < 20
                  ? difference < 10
                      ? Color(0xFFfa0d00)
                      : Color(0xFFFF86E45)
                  : Color(0xFFDFF1FF))),
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
                AssetImage('assets/food/${name.toLowerCase()}.png'),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${quantity.toString()}x $name",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Kcal'),
                  Text(ingredientsList[name]['calories'].toString())
                ],
              ),
              Column(
                children: [
                  Text('Carbs'),
                  Text(ingredientsList[name]['carbohydrates'].toString())
                ],
              ),
              Column(
                children: [
                  Text('Fats'),
                  Text(ingredientsList[name]['fats'].toString())
                ],
              ),
              Column(
                children: [
                  Text('Proteins'),
                  Text(ingredientsList[name]['proteins'].toString())
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Days to expire:\n $difference',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFff6961),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      db.removeSingleFoodToFridge(familyID, name);
                    },
                    icon: Icon(Icons.exposure_minus_1),
                  ),
                ),
              ),
              Text(
                'Add\nor\nRemove',
                textAlign: TextAlign.center,
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFb8d8be),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      db.addSingleFoodToFridge(familyID, name);
                    },
                    icon: Icon(Icons.exposure_plus_1),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
