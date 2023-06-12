import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';

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
            return DishSuccessView(state.dishes ?? []);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
