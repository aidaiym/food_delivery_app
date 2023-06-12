import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../export_files.dart';

class CategoryViewBody extends StatefulWidget {
  const CategoryViewBody({super.key});

  @override
  State<CategoryViewBody> createState() => _CategoryViewBodyState();
}

class _CategoryViewBodyState extends State<CategoryViewBody> {
  @override
  void initState() {
    context.read<CategoryCubit>().getPost();
    super.initState();
  }

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
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FetchStatus.error:
              return const Center(
                child: Text(AppString.error),
              );
            case FetchStatus.success:
              return CategoryListWidget(state.categories ?? []);
          }
        },
      ),
    );
  }
}
