import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_files.dart';

class DishView extends StatelessWidget {
  const DishView({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProductCubit(ProductService()),
        child: ProductViewBody(category: category),
      ),
    );
  }
}
