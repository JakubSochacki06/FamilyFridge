import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'package:familyfridge/widgets/food_in_fridge_card.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/text_styles.dart';

class FridgePage extends StatefulWidget {
  const FridgePage({super.key});

  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  late TextEditingController searchController;
  List<dynamic> sortedIngredients = [];

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFF86E45),
        label: Text('+',
          style: TextStyle(
            fontSize: 30,
              color: Colors.white),
        ),
        onPressed:  () {
          Navigator.pushNamed(context, '/add_food');
        },
      ),
      body: Consumer<FirebaseUserProvider>(
        builder: (context, provider, child) {
          return StreamBuilder(
            stream: db.streamFamilyData(provider.user.familyID!),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Text('No network connection!'),
                );
              if (snapshot.hasData) {
                Map<String, dynamic> foodInFridge = snapshot.data!.get('food');
                // List<dynamic> availableIngredients =
                // sortedIngredients.length == 0
                //     ? foodInFridge.values.toList()
                //     : sortedIngredients;
                return Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'What\'s in Your Fridge',
                          style: kFridgePageMainTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        controller: searchController,
                        onChanged: (String query) {
                          setState(() {
                            sortedIngredients = [];
                            foodInFridge.forEach((key, value) {
                              if (key.toLowerCase().contains(query)) {
                                value['name'] = key;
                                sortedIngredients.add(value);
                              }
                            });
                          });
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF71C9CE), width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          hintText: 'Search for food',
                          hintStyle: const TextStyle(color: Colors.black12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    sortedIngredients.length == 0 &&
                            searchController.text.length > 0
                        ? Expanded(
                            flex: 11,
                            child: Center(
                                child: Text(
                              'Can\'t find what you are looking for!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                            )),
                          )
                        : Expanded(
                            flex: 11,
                            child: GridView.builder(
                              itemCount: sortedIngredients.length == 0
                                  ? searchController.text.length > 0
                                      ? 1
                                      : foodInFridge.length
                                  : sortedIngredients.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.2)
                              ),
                              itemBuilder: (_, index) {
                                return FoodInFridgeCard(
                                  familyID: provider.user.familyID!,
                                  name: sortedIngredients.length == 0
                                      ? foodInFridge.keys.toList()[index]
                                      : sortedIngredients[index]['name'],
                                  quantity: sortedIngredients.length == 0
                                      ? foodInFridge.values.toList()[index]
                                          ['quantity']
                                      : sortedIngredients[index]['quantity'],
                                  expMonth: sortedIngredients.length == 0
                                      ? foodInFridge.values.toList()[index]
                                          ['month']
                                      : sortedIngredients[index]['month'],
                                  expYear: sortedIngredients.length == 0
                                      ? foodInFridge.values.toList()[index]
                                          ['year']
                                      : sortedIngredients[index]['year'],
                                );
                              },
                            ),
                          ),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          );
        },
      ),
    );
  }
}
