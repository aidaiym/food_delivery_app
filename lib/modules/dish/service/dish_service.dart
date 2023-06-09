import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../export_files.dart';

class DishService {
  Future<List<Dish>> getDishes() async {
    const apiUrl =
        'https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final dishes = List<Dish>.from(jsonData['dishes'].map(
        (dishData) => Dish.fromJson(dishData),
      ));
      return dishes;
    } else {
      throw Exception('Failed to fetch dishes');
    }
  }
}
