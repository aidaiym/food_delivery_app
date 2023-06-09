import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/modules/basket/logic/cart_cubit.dart';
import '../../../export_files.dart';

class DishListView extends StatelessWidget {
  const DishListView({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(category.name),
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider<DishCubit>(
            create: (context) => DishCubit(DishService()),
          ),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(),
          ),
        ],
        child: const DishViewBody(),
      ),
    );
  }
}

class DishViewBody extends StatefulWidget {
  const DishViewBody({super.key});

  @override
  State<DishViewBody> createState() => _DishViewBodyState();
}

class _DishViewBodyState extends State<DishViewBody> {
  @override
  void initState() {
    context.read<DishCubit>().getDishe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DishCubit, DishState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FetchStatus.error:
              return const Center(
                child: Text('Error'),
              );
            case FetchStatus.success:
              return DishListWidget(state.dishes ?? []);
          }
        },
      ),
    );
  }
}

class DishListWidget extends StatefulWidget {
  const DishListWidget(this.dishes, {super.key});
  final List<Dish> dishes;
  @override
  State<DishListWidget> createState() => _DishListWidgetState();
}

class _DishListWidgetState extends State<DishListWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.8,
        ),
        itemCount: widget.dishes.length,
        itemBuilder: (context, index) {
          Dish dish = widget.dishes[index];
          return GestureDetector(
            onTap: () {
              dishDialog(context, dish);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 109,
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xffD8D8D8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(dish.imageUrl)),
                SizedBox(
                  width: 109,
                  height: 30,
                  child: Text(
                    dish.name,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> dishDialog(BuildContext context, Dish dish) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 343,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 311,
                  height: 232,
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F7F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          dish.imageUrl,
                          width: 311,
                          height: 204,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 54, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border_outlined),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(top: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${dish.price} Р',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      '${dish.weight} г',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Description: ${dish.description}',
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    cartCubit.addToCart(dish);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(311, 48),
                    backgroundColor: const Color(0xff3364E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Добавить в корзину'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
