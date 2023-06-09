import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cart_cubit.dart';

class BasketView extends StatelessWidget {
  const BasketView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: const CartPage(),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return ListTile(
                leading: Image.asset(
                  item.dish.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(item.dish.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cost: \$${item.dish.price.toStringAsFixed(2)}'),
                    Text('Weight: ${item.dish.weight.toStringAsFixed(2)}g'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (item.quantity > 1) {
                          cartCubit.updateCartItem(
                              item.dish, item.quantity - 1);
                        } else {
                          cartCubit.removeFromCart(item.dish);
                        }
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cartCubit.updateCartItem(item.dish, item.quantity + 1);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${state.totalCost.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  child: const Text('Pay'),
                  onPressed: () {
                    // Handle payment logic here
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
