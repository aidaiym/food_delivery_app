import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

part 'cart_state.dart';

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
