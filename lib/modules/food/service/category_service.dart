import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/category_model.dart';

class CategoryService {
  Future<List<Category>> getCategories() async {
    const apiUrl =
        'https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final categories = List<Category>.from(jsonData['сategories'].map(
        (category) => Category(
          id: category['id'],
          name: category['name'],
          imageUrl: category['image_url'],
        ),
      ));
      return categories;
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
