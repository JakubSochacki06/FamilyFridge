import 'dart:convert';
import 'package:familyfridge/screens/recipe_card_popup.dart';
import 'package:familyfridge/widgets/recipe_card.dart';
import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'package:familyfridge/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/text_styles.dart';
import 'package:http/http.dart';
import 'package:familyfridge/widgets/random_recipe_card.dart';

class FindRecipePage extends StatelessWidget {
  FindRecipePage({super.key});

  final DatabaseService db = DatabaseService();

  Future<List<dynamic>> getRecipesFromFridge(
      Map<String, dynamic> foodInFridge) async {
    String foodQuery = '';
    foodInFridge.forEach((key, value) {
      foodQuery += "$key,";
    });
    Response response = await get(Uri.parse(
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$foodQuery&number=10&ranking=1&ignorePantry=true&apiKey=59df35dd776545ffa50fc42732e0c397'));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getRandomRecipes() async {
    Response response = await get(Uri.parse(
        'https://api.spoonacular.com/recipes/random?number=10&apiKey=59df35dd776545ffa50fc42732e0c397'));
    return jsonDecode(response.body)['recipes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                if (foodInFridge.length == 0) {
                  return FutureBuilder(
                      future: getRandomRecipes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    'Your fridge is empty, so look at these random recipes!',
                                    style: kFridgePageMainTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 11,
                                child: GridView.builder(
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .width /
                                          (MediaQuery.of(context).size.height /
                                              1.3)),
                                  itemBuilder: (_, index) {
                                    return RandomRecipeCard(
                                      title: snapshot.data![index]['title'],
                                      imageURL: snapshot.data![index]['image'],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }
                  );
                }
                return FutureBuilder(
                  future: getRecipesFromFridge(foodInFridge),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                'What can you cook\nBased on ingredients in your fridge',
                                style: kFridgePageMainTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 11,
                            child: GridView.builder(
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.3)),
                              itemBuilder: (_, index) {
                                return RecipeCard(
                                  title: snapshot.data![index]['title'],
                                  imageURL: snapshot.data![index]['image'],
                                  usedIngredientsAmount: snapshot.data![index]
                                          ['usedIngredientCount']
                                      .toString(),
                                  missedInfredientsAmount: snapshot.data![index]
                                          ['missedIngredientCount']
                                      .toString(),
                                  onTap: (){
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) => Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: RecipeCardPopup(usedIngredientsList: snapshot.data![index]['usedIngredients'], missedIngredientsList: snapshot.data![index]['missedIngredients']),
                                      ),
                                    );
                                  }
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
