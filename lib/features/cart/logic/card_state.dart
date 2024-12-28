part of 'card_cubit.dart';

@immutable
sealed class cardState {}

final class CategoryInitial extends cardState {}

class GetCartItemLoadingState extends cardState {}

class GetCartItemSuccessState extends cardState {
  final Cart cart;

  GetCartItemSuccessState(this.cart);
}

class GetCartItemErrorState extends cardState {
  final String error;

  GetCartItemErrorState(this.error);
}

class AddCartItemSuccessState extends cardState {
  CartProduct cartProduct;
  AddCartItemSuccessState(this.cartProduct);
}

class ItemBuyNow extends cardState {}
