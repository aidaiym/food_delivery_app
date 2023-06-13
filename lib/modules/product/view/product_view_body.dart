import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

class ProductViewBody extends StatefulWidget {
  const ProductViewBody({super.key, required this.category});
  final Category category;
  @override
  // ignore: no_logic_in_create_state
  State<ProductViewBody> createState() => _ProductViewBodyState(category);
}

class _ProductViewBodyState extends State<ProductViewBody> {
  final Category category;

  _ProductViewBodyState(this.category);

  @override
  void initState() {
    context.read<ProductCubit>().getDishe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.status == FetchStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == FetchStatus.error) {
            return const Center(
              child: Text(AppString.error),
            );
          } else if (state.status == FetchStatus.success) {
            return ProductSuccessView(
              state.dishes ?? [],
              category: category,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
