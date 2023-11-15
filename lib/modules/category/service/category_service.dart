import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/category_model.dart';
class CategoryService {
  Future<List<Category>> getCategories() async {
    const apiUrl = 'https://api.slingacademy.com/v1/sample-data/users';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['users'];
      final List<Category> categories = jsonData.map((category) {
        return Category(
          id: category['id'], // Assuming 'id' is a String, adjust if it's an integer
          name: '${category['first_name']} ${category['last_name']}',
          imageUrl: category['profile_picture'],
        );
      }).toList();
      return categories;
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}

