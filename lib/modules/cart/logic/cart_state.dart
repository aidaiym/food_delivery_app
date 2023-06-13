part of 'cart_cubit.dart';

class CartItem extends Equatable {
  final Dish dish;
  int quantity;

  CartItem(this.dish, this.quantity);

  @override
  List<Object?> get props => [dish, quantity];

  int get totalCost {
    return (dish.price * quantity).round();
  }

  Map<String, dynamic> toJson() {
    return {
      'dish': dish.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final dishJson = json['dish'] as Map<String, dynamic>;
    final dish = Dish.fromJson(dishJson);
    final quantity = json['quantity'] as int;
    return CartItem(dish, quantity);
  }
}

class CartState extends Equatable {
  final List<CartItem> items;
  final double totalCost;

  const CartState(this.items, this.totalCost);

  double get totalQuantity {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  List<Object?> get props => [items, totalCost];

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalCost': totalCost,
    };
  }

  factory CartState.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>;
    final items =
        itemsJson.map((itemJson) => CartItem.fromJson(itemJson)).toList();
    final totalCost =
        json['totalCost'] as double? ?? 0.0; // Provide a default value if null
    return CartState(items, totalCost);
  }
}
