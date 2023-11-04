import 'package:http/http.dart';
import 'dart:convert';
class HttpService{

  Future<List<dynamic>> getIngredientsList() async {
    Response response =
    await get(Uri.parse('https://familyfridge.onrender.com/ingredientsList'));
    return jsonDecode(response.body);
  }
}