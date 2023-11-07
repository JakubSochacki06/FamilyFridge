import 'package:flutter/material.dart';
import 'package:familyfridge/services/database_service.dart';

class AddShoppingListPopup extends StatelessWidget {
  final String familyID;
  AddShoppingListPopup({required this.familyID});

  @override
  Widget build(BuildContext context) {
    String text = '';
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add shopping list',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Color(0xFFF4745B),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Shopping list name",
              fillColor: Colors.white,
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black38, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            textAlign: TextAlign.center,
            onChanged: (newText){
              text = newText;
            },
          ),
          ElevatedButton(
            onPressed: () {
              DatabaseService db = DatabaseService();
              db.addBlankShoppingList(familyID, text);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: const Color(0xFFF4745B),
              minimumSize: const Size(20, 50),
              elevation: 0,
            ),
            child: const Text('Add shopping list', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
