import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'package:familyfridge/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/widgets/submit_food_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AddFoodPopup extends StatelessWidget {
  final List<String> selectedFoodList;

  AddFoodPopup({required this.selectedFoodList});

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> foodInfo = {};
    return Consumer<FirebaseUserProvider>(
      builder: (_, provider, child) => Container(
        width: 400,
        height: 500,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Add extra info about your food',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Color(0xFFFF86E45),
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: selectedFoodList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  foodInfo[selectedFoodList[index]] = {};
                  return SubmitFoodRow(
                    foodName: selectedFoodList[index],
                    onChangedQuantity: (String quantity) {
                      foodInfo[selectedFoodList[index]]!['quantity'] = int.parse(quantity);
                    },
                    onChangedMonth: (String month) {
                      print(month);
                      foodInfo[selectedFoodList[index]]!['month'] = int.parse(month);
                    },
                    onChangedYear: (String year) {
                      print(year);
                      foodInfo[selectedFoodList[index]]!['year'] = int.parse(year);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  DatabaseService db = DatabaseService();
                  db.addFoodToFridge(provider.user.familyID!, foodInfo);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Dodaj',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(200, 50),
                  backgroundColor: const Color(0xFFFF86E45),
                  disabledBackgroundColor: Colors.black12,
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
