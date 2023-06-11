part of 'cart_cubit.dart';

class CartItem {
  final Dish dish;
  int quantity;

  CartItem(this.dish, this.quantity);
}

class CartState extends Equatable {
  final List<CartItem> items;
  const CartState(this.items);
  double get totalCost {
    return items.fold(
        0, (sum, item) => sum + (item.dish.price * item.quantity));
  }

  @override
  List<Object> get props => [items.length, items];
}

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Dish dish;

  AddToCartEvent(this.dish);

  @override
  List<Object> get props => [dish];
}

class UpdateCartItemEvent extends CartEvent {
  final Dish dish;
  final int quantity;

  UpdateCartItemEvent(this.dish, this.quantity);

  @override
  List<Object> get props => [dish, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final Dish dish;

  RemoveFromCartEvent(this.dish);

  @override
  List<Object> get props => [dish];
}
