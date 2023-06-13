// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState({this.status = FetchStatus.loading, this.dishes});

  final FetchStatus status;
  final List<Dish>? dishes;

  @override
  List<Object?> get props => [status];

  ProductState copyWith({FetchStatus? status, List<Dish>? dishes}) {
    return ProductState(
      status: status ?? this.status,
      dishes: dishes ?? this.dishes,
    );
  }
}
