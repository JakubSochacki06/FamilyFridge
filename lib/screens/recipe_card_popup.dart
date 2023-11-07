import 'package:flutter/material.dart';

class RecipeCardPopup extends StatelessWidget {
  final List<dynamic> usedIngredientsList;
  final List<dynamic> missedIngredientsList;

  RecipeCardPopup(
      {required this.usedIngredientsList, required this.missedIngredientsList});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
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
            Text('Check what ingredients you have and what you have to buy', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: usedIngredientsList.length > 5? 5 : usedIngredientsList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('✅ ${usedIngredientsList[index]['name']}'),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: missedIngredientsList.length > 5? 5:missedIngredientsList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('❌ ${missedIngredientsList[index]['name']}'),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
