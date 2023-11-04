import 'package:familyfridge/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:familyfridge/widgets/ingredient_card.dart';
import 'adding_food_popup.dart';
import 'package:familyfridge/data/food.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  List<String> ingredientsSelected = [];
  List<dynamic> sortedIngredients = [];
  late TextEditingController searchController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
            ingredientsSelected.isEmpty ? Colors.grey : Color(0xFFF86E45),
        label: Text(
          ingredientsSelected.isEmpty
              ? 'Add atleast 1 item'
              : 'Specify selected ✔',
          style: TextStyle(
              color: ingredientsSelected.isEmpty ? Colors.black : Colors.white),
        ),
        onPressed: ingredientsSelected.isEmpty
            ? null
            : () {
                List<String> copiedIngredientsSelected = ingredientsSelected;
                ingredientsSelected = [];
                showModalBottomSheet(
                  context: context,
                  // makes it to sit right above keyboard
                  isScrollControlled: true,
                  builder: (context) => Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddFoodPopup(selectedFoodList: copiedIngredientsSelected),
                  ),
                );
              },
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Select food that you would\nlike to add to your fridge!',
                style: kFridgePageMainTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (String value) {
                setState(() {
                  sortedIngredients = [];
                  for (dynamic foodSpecs in ingredientsList) {
                    if (foodSpecs['name']
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      sortedIngredients.add(foodSpecs);
                    }
                  }
                });
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF71C9CE), width: 2.0),
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
          Expanded(
            flex: 11,
            child: GridView.builder(
              itemCount: sortedIngredients.length == 0
                  ? ingredientsList.length
                  : sortedIngredients.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemBuilder: (_, index) {
                List<dynamic> availableIngredients =
                    sortedIngredients.length == 0
                        ? ingredientsList
                        : sortedIngredients;
                return IngredientCard(
                  name: availableIngredients[index]['name'],
                  calories: availableIngredients[index]['calories'].toDouble(),
                  carbohydrates:
                      availableIngredients[index]['carbohydrates'].toDouble(),
                  fats: availableIngredients[index]['fats'].toDouble(),
                  proteins: availableIngredients[index]['proteins'].toDouble(),
                  isActive: ingredientsSelected
                      .contains(availableIngredients[index]['name']),
                  onTap: () {
                    ingredientsSelected
                            .contains(availableIngredients[index]['name'])
                        ? ingredientsSelected
                            .remove(availableIngredients[index]['name'])
                        : ingredientsSelected
                            .add(availableIngredients[index]['name']);
                    setState(() {});
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
