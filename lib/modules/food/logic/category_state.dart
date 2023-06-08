// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_cubit.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.status = FetchStatus.loading,
    this.categories,
  });

  final FetchStatus status;
  final List<Category>? categories;

  @override
  List<Object?> get props => [status];

  CategoryState copyWith({FetchStatus? status, List<Category>? categories}) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }
}
