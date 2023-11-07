import 'package:flutter/material.dart';
import 'package:familyfridge/services/database_service.dart';

class AddProductPopup extends StatelessWidget {
  final String familyID;
  final int listIndex;
  AddProductPopup({required this.familyID, required this.listIndex});

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
            'Add product to shopping list',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Color(0xFFF4745B),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "product name",
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
              db.addNewProductToShoppingList(familyID, text, listIndex);
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
