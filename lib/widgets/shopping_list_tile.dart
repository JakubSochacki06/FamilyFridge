import 'package:familyfridge/screens/shopping_list_page.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/text_styles.dart';

class ShoppingListTile extends StatelessWidget {
  final String title;
  final Map<String,dynamic> shoppingList;
  final int listIndex;
  final String familyID;

  const ShoppingListTile({required this.title, required this.shoppingList, required this.familyID, required this.listIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              title,
              style: kShoppingListsMainTextStyle,
            ),
            Text(
              '${shoppingList.length.toString()} products',
              style: kShoppingListsSecondaryTextStyle,
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingListPage(title: title, shoppingList: shoppingList, familyID: familyID, listIndex: listIndex,)),
            );
          },
          icon: Icon(Icons.navigate_next),
        ),
      ],
    );
  }
}
