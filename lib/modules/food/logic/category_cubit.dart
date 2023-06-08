import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_files.dart';
import '../../../models/category_model.dart';
import '../service/category_service.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoryService) : super(const CategoryState());

  final CategoryService categoryService;

  Future<void> getPost() async {
    final categories = await categoryService.getCategories();
    // ignore: unnecessary_null_comparison
    if (categories != null) {
      emit(state.copyWith(status: FetchStatus.success, categories: categories));
    } else {
      emit(state.copyWith(status: FetchStatus.error));
    }
  }
}
