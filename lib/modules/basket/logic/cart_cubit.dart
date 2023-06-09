import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

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
  List<Object> get props => [items];
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

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState([]));

  void addToCart(Dish dish) {
    final itemIndex = state.items.indexWhere((item) => item.dish == dish);

    if (itemIndex != -1) {
      final updatedItems = List<CartItem>.from(state.items);

      final updatedItem = updatedItems[itemIndex];
      updatedItem.quantity += 1;
      emit(CartState(updatedItems));
    } else {
      final newItem = CartItem(dish, 1);
      emit(CartState([...state.items, newItem]));
    }
  }

  void updateCartItem(Dish dish, int quantity) {
    final itemIndex = state.items.indexWhere((item) => item.dish == dish);
    if (itemIndex != -1) {
      final updatedItems = List<CartItem>.from(state.items);
      if (quantity > 0) {
        final updatedItem = updatedItems[itemIndex];
        updatedItem.quantity = quantity;
        emit(CartState(updatedItems));
      } else {
        updatedItems.removeAt(itemIndex);
        emit(CartState(updatedItems));
      }
    }
  }

  void removeFromCart(Dish dish) {
    final updatedItems = List<CartItem>.from(state.items);
    updatedItems.removeWhere((item) => item.dish == dish);
    emit(CartState(updatedItems));
  }
}
