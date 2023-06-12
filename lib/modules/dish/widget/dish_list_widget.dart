import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

class DishSuccessView extends StatefulWidget {
  const DishSuccessView(this.dishes, {Key? key}) : super(key: key);
  final List<Dish> dishes;

  @override
  State<DishSuccessView> createState() => _DishSuccessViewState();
}

class _DishSuccessViewState extends State<DishSuccessView>
    with TickerProviderStateMixin {
  final List<String> tags = [
    'Все меню',
    'С рисом',
    'Салаты',
    'С рыбой',
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tags.length);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DishCubit, DishState>(
      builder: (context, state) {
        return DefaultTabController(
          length: tags.length,
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 18.0),
                  child: SizedBox(
                    width: 44,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/user_avatar.png'),
                      radius: 16,
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                controller: _tabController,
                tabs: tags.map((e) {
                  return SizedBox(
                    height: 35,
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: Text(e),
                      elevation: 2.0,
                      backgroundColor: _tabController.index == tags.indexOf(e)
                          ? AppColors.main
                          : Colors.white,
                      labelStyle: TextStyle(
                        color: _tabController.index == tags.indexOf(e)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: tags.map((tag) {
                final filteredDishes = widget.dishes
                    .where((dish) => dish.tegs.contains(tag))
                    .toList();
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: filteredDishes.length,
                  itemBuilder: (context, index) {
                    Dish dish = filteredDishes[index];
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
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
