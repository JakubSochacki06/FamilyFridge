import 'package:familyfridge/widgets/shopping_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'package:familyfridge/services/database_service.dart';
import 'add_shopping_list_popup.dart';

class ShoppingListsPage extends StatelessWidget {
  const ShoppingListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    return Consumer<FirebaseUserProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Color(0xFFF86E45),
                label: Text( "Add new shopping list",
                  style: TextStyle(
                      color: Colors.white),
                ),
                onPressed:  () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddShoppingListPopup(familyID: provider.user.familyID!,),
                    ),
                  );
                },
              ),
              body: StreamBuilder(
                stream: db.streamFamilyData(provider.user.familyID!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text('No network connection!'),
                    );
                  if (snapshot.hasData) {
                    List<dynamic> shoppingLists = snapshot.data!.get(
                        'shoppingLists');
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('Shopping lists', style: kShoppingListsHeaderTextStyle,),
                          SizedBox(height: MediaQuery.of(context).size.height*0.1),
                          Text('Our recommendations', style: kShoppingListsSecondaryTextStyle, textAlign: TextAlign.left),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01),
                          ShoppingListTile(title: shoppingLists[0]['title'], shoppingList: shoppingLists[0]['list'], familyID: provider.user.familyID!, listIndex: 0,),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01),
                          Text('Your shopping lists', style: kShoppingListsSecondaryTextStyle, textAlign: TextAlign.left,),
                          shoppingLists.length -1 == 0? Center(child: Text('You have no shopping lists\nClick the button to add one!', textAlign: TextAlign.center, style: kShoppingListsMainTextStyle,)) : Expanded(
                            child: ListView.builder(
                                itemCount: shoppingLists.length -1,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ShoppingListTile(title: shoppingLists[index+1]['title'], shoppingList: shoppingLists[index+1]['list'], familyID: provider.user.familyID!, listIndex: index+1,);
                                }),
                          ),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            );
          }
      );
  }
}
