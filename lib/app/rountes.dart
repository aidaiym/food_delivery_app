import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../export_files.dart';
import '../modules/cart/view/cart_view.dart';

class AppRouter {
  static const String main = '/';
  static const String home = '/home';
  static const String product = '/product';
  static const String cart = '/cart';

  final CartCubit _cartCubit = CartCubit();

  Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainView());
      case '/home':
        return MaterialPageRoute(builder: (_) => const CategoryView());
      // case '/product':
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //             value: _cartCubit,
      //             child: DishView(cat),
      //           ));
      case '/cart':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _cartCubit, child: const CartView()));
      default:
        throw Exception(
            'no builder specified for route named: [${settings.name}]');
    }
  }
}
