class Dish {
  final int? id;
  final String? name;
  final int? price;
  final int? weight;
  final String? description;
  final String? imageUrl;
  final List<String>? tags;

  Dish({
     this.id,
     this.name,
     this.price,
     this.weight,
     this.description,
     this.imageUrl,
     this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'weight': weight,
      'description': description,
      'image_url': imageUrl,
      'tegs': tags,
    };
  }

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      weight: json['weight'],
      description: json['description'],
      imageUrl: json['image_url'],
      tags: List<String>.from(json['tegs']),
    );
  }
}
