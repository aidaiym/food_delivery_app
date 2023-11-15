// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

class ProductSuccessView extends StatefulWidget {
  const ProductSuccessView(this.dishes, {Key? key, required this.category})
      : super(key: key);
  final List<Dish> dishes;
  final Category category;
  @override
  State<ProductSuccessView> createState() => _ProductSuccessViewState(category);
}

class _ProductSuccessViewState extends State<ProductSuccessView>
    with TickerProviderStateMixin {
  final List<String> tags = [
    'Все меню',
    'С рисом',
    'Салаты',
    'С рыбой',
  ];

  late TabController _tabController;
  final Category category;

  _ProductSuccessViewState(this.category);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tags.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
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
              onTap: (index) {
                setState(() {
                  _tabController.index = index;
                });
              },
              tabs: tags.map((e) {
                final isSelected = _tabController.index == tags.indexOf(e);
                return SizedBox(
                  height: 35,
                  child: Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    label: Text(e),
                    elevation: 2.0,
                    backgroundColor: isSelected ? AppColors.main : Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          body: IndexedStack(
            index: _tabController.index,
            children: tags.map((tag) {
            
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
                      productDialog(context, dish);
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
                          child: Image.network(dish.imageUrl!),
                        ),
                        SizedBox(
                          width: 109,
                          height: 30,
                          child: Text(
                            dish.name!,
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
        );
      },
    );
  }
}
