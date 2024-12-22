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

// States for adding an item to the cart

class AddCartItemSuccessState extends cardState {
  final Cart cart;
  AddCartItemSuccessState(this.cart);
}


class UpdateItemCountSuccessState extends cardState {
  final Cart cart;
  UpdateItemCountSuccessState(this.cart);
}
