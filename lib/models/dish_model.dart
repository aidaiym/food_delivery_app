class Dish {
  final int id;
  final String name;
  final int price;
  final int weight;
  final String description;
  final String imageUrl;
  final List<String> tegs;

  Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.weight,
    required this.description,
    required this.imageUrl,
    required this.tegs,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      weight: json['weight'],
      description: json['description'],
      imageUrl: json['image_url'],
      tegs: List<String>.from(json['tegs']),
    );
  }
}
