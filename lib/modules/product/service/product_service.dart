import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../export_files.dart';

class ProductService {
  Future<List<Dish>> getDishes() async {
    const apiUrl =
        'https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final dishesData = jsonData['dishes'] as List<dynamic>;
      final dishes = dishesData
          .map((dishData) => Dish.fromJson(dishData as Map<String, dynamic>))
          .toList();
      return dishes;
    } else {
      throw Exception('Failed to fetch dishes');
    }
  }
}
