import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

class DishViewBody extends StatefulWidget {
  const DishViewBody({super.key, required this.category});
  final Category category;
  @override
  State<DishViewBody> createState() => _DishViewBodyState(category);
}

class _DishViewBodyState extends State<DishViewBody> {
  final Category category;

  _DishViewBodyState(this.category);

  @override
  void initState() {
    context.read<DishCubit>().getDishe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DishCubit, DishState>(
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
            return DishSuccessView(
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
