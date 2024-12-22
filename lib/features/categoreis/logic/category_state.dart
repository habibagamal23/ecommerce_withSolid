part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}


class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Product> productResponse;
   CategorySuccess(this.productResponse);

}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}