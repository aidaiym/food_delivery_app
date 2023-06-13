import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_files.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.dishService) : super(const ProductState());

  final ProductService dishService;

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
