import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../export_files.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  static const _cartKey = 'cart';

  CartCubit() : super(const CartState([], 0.0)) {
    _loadCartState();
  }

  Future<void> _loadCartState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);
      if (cartJson != null) {
        final cartState = CartState.fromJson(jsonDecode(cartJson));
        emit(cartState);
      }
    } catch (e) {
      throw Exception('Error $e ');
    }
  }

  Future<void> _saveCartState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = jsonEncode(state.toJson());
      await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      throw Exception('Error $e ');
    }
  }

  double calculateTotalCost(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + item.totalCost);
  }

  void addToCart(Dish dish) {
    final itemIndex = state.items.indexWhere((item) => item.dish == dish);
    if (itemIndex != -1) {
      final updatedItems = List<CartItem>.from(state.items);
      final updatedItem = updatedItems[itemIndex];
      updatedItem.quantity += 1;
      emit(CartState(updatedItems, calculateTotalCost(updatedItems)));
    } else {
      final newItem = CartItem(dish, 1);
      emit(CartState([...state.items, newItem],
          calculateTotalCost([...state.items, newItem])));
    }
  }

  void updateCartItem(Dish dish, int quantity) {
    final updatedItems = List<CartItem>.from(state.items);
    final itemIndex = updatedItems.indexWhere((item) => item.dish == dish);
    if (itemIndex != -1) {
      final updatedItem = updatedItems[itemIndex];
      updatedItem.quantity = quantity;
      emit(CartState(updatedItems, calculateTotalCost(updatedItems)));
    }
  }

  void removeFromCart(Dish dish) {
    final updatedItems = List<CartItem>.from(state.items);
    updatedItems.removeWhere((item) => item.dish == dish);
    emit(CartState(updatedItems, calculateTotalCost(updatedItems)));
  }

  void increaseQuantity(Dish dish) {
    addToCart(dish);
  }

  void decreaseQuantity(Dish dish) {
    final itemIndex = state.items.indexWhere((item) => item.dish == dish);
    if (itemIndex != -1) {
      final updatedItems = List<CartItem>.from(state.items);
      final updatedItem = updatedItems[itemIndex];
      updatedItem.quantity -= 1;
      if (updatedItem.quantity <= 0) {
        removeFromCart(dish);
      } else {
        emit(CartState(updatedItems, calculateTotalCost(updatedItems)));
      }
    }
  }

  @override
  void emit(CartState state) {
    super.emit(state);
    _saveCartState();
  }
}
