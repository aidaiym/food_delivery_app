import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_files.dart';
part 'dish_state.dart';

class DishCubit extends Cubit<DishState> {
  DishCubit(this.dishService) : super(const DishState());

  final DishService dishService;
  List<Dish>? filteredDishes;

// filter by Tag
  void filterDishesByTag(String tag) {
    List<Dish> filteredDishes = [];
    if (tag == 'Все меню') {
      emit(state.copyWith(status: FetchStatus.success, dishes: state.dishes));
    } else {
      filteredDishes =
          state.dishes!.where((dish) => dish.tegs.contains(tag)).toList();
      emit(state.copyWith(status: FetchStatus.success, dishes: filteredDishes));
    }
  }

  Future<void> getDishe() async {
    final dishes = await dishService.getDishes();
    // ignore: unnecessary_null_comparison
    if (dishes != null) {
      emit(state.copyWith(status: FetchStatus.success, dishes: dishes));
    } else {
      emit(state.copyWith(status: FetchStatus.error));
    }
  }
}
