import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../export_files.dart';

class ProductService {
  Future<List<Dish>> getDishes() async {
    const apiUrl = 'https://api.slingacademy.com/v1/sample-data/users';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['users'];
      final List<Dish> dishes = jsonData.map((userData) {
        return Dish(
          id: userData['id'],
          name: '${userData['first_name']} ${userData['last_name']}',
          imageUrl: userData['profile_picture'],
        );
      }).toList();
      return dishes;
    } else {
      throw Exception('Failed to fetch dishes');
    }
  }
}

