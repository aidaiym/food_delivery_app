// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dish_cubit.dart';

class DishState extends Equatable {
  const DishState({this.status = FetchStatus.loading, this.dishes});

  final FetchStatus status;
  final List<Dish>? dishes;

  @override
  List<Object?> get props => [status];

  DishState copyWith({FetchStatus? status, List<Dish>? dishes}) {
    return DishState(
      status: status ?? this.status,
      dishes: dishes ?? this.dishes,
    );
  }
}
