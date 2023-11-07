import 'package:familyfridge/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/services/database_service.dart';
import 'add_product_popup.dart';

class ShoppingListPage extends StatefulWidget {
  final String title;
  final String familyID;
  final int listIndex;
  final Map<String, dynamic> shoppingList;

  ShoppingListPage({required this.title, required this.shoppingList, required this.familyID, required this.listIndex});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFF86E45),
          label: Text('Add new product',
            style: TextStyle(
                color: Colors.white),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              // makes it to sit right above keyboard
              isScrollControlled: true,
              builder: (context) => Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddProductPopup(familyID: widget.familyID, listIndex: widget.listIndex),
              ),
            );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                widget.title,
                style: kShoppingListsHeaderTextStyle,
              ),
              ListView.builder(
                itemCount: widget.shoppingList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String key = widget.shoppingList.keys.elementAt(index);
                  bool value = widget.shoppingList.values.elementAt(index);
                  return ListTile(
                    title: Text(
                      key,
                      style: TextStyle(
                        decoration: value ? TextDecoration.lineThrough : null,
                        decorationThickness: 2,
                      ),
                    ),
                    trailing: Checkbox(
                        value: value,
                        activeColor: Colors.lightBlueAccent,
                        onChanged: (bool){
                          setState(() {
                            value = !value;
                            db.changeShoppingListProductStatus(widget.familyID, key, widget.listIndex);
                          });
                          print(bool);
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
