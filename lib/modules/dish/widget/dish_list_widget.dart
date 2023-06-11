import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

class DishListWidget extends StatefulWidget {
  const DishListWidget(this.dishes, {Key? key}) : super(key: key);

  final List<Dish> dishes;

  @override
  State<DishListWidget> createState() => _DishListWidgetState();
}

class _DishListWidgetState extends State<DishListWidget> {
  final List<String> tags = [
    'Все меню',
    'С рисом',
    'Салаты',
    'С рыбой',
  ];
  String selectedTag = 'Все меню';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: tags.map((tag) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                height: 35,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedTag = tag;
                      context.read<DishCubit>().filterDishesByTag(tag);
                    });
                  },
                  child: Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    label: Text(tag),
                    elevation: 2.0,
                    backgroundColor:
                        selectedTag == tag ? AppColors.main : Colors.white,
                    labelStyle: TextStyle(
                        color: selectedTag == tag ? Colors.white : Colors.black,
                        fontSize: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        BlocBuilder<DishCubit, DishState>(
          builder: (context, state) {
            return Expanded(
              child: GridView.builder(
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
                            color: AppColors.cWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(dish.imageUrl),
                        ),
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
                },
              ),
            );
          },
        ),
      ],
    );
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
                    color: AppColors.cWhite,
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
                MainButton(
                    buttonText: AppString.addCart,
                    onTap: () {
                      cartCubit.addToCart(dish);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
