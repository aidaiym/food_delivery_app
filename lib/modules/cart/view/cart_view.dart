import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../export_files.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDate =
        DateFormat(AppString.dateTimeFormat).format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: MainAppBar(currentDate: currentDate),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: SizedBox(
              width: 44,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user_avatar.png'),
                radius: 16,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return ListTile(
                leading: Image.network(
                  item.dish.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(item.dish.name),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${item.dish.price.toStringAsFixed(2)} ₽'),
                    Text('${item.dish.weight.toStringAsFixed(2)} г'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        final updatedQuantity = item.quantity - 1;
                        if (updatedQuantity > 0) {
                          BlocProvider.of<CartCubit>(context)
                              .updateCartItem(item.dish, updatedQuantity);
                        } else {
                          BlocProvider.of<CartCubit>(context)
                              .removeFromCart(item.dish);
                        }
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        final updatedQuantity = item.quantity + 1;
                        BlocProvider.of<CartCubit>(context)
                            .updateCartItem(item.dish, updatedQuantity);
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainButton(
              onTap: () {},
              buttonText: 'Оплатить: ${state.totalCost.toStringAsFixed(2)}',
            ),
          );
        },
      ),
    );
  }
}
