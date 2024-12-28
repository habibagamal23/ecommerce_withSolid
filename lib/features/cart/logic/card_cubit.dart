import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../home/data/models/product.dart';
import '../data/models/CartListResponse.dart';
import '../data/models/CartProduct.dart';
import '../data/repos/cardepo.dart';

part 'card_state.dart';

class cardCubit extends Cubit<cardState> {
  final CartRepository _catRepo;

  cardCubit(this._catRepo) : super(CategoryInitial());

  double totalcart = 0.0;

  void getCart() async {
    emit(GetCartItemLoadingState());
    final result = await _catRepo.getCart();
    if (result.isSuccess) {
      emit(GetCartItemSuccessState(result.data!));
      totalcart = result.data!.total;
    } else {
      emit(GetCartItemErrorState(result.error!));
    }
  }

  void addProduct(Product product) async {
    final cartProduct = CartProduct(
      id: product.id!,
      title: product.title!,
      price: product.price!,
      quantity: 1,
      total: product.price!,
      discountPercentage: product.discountPercentage!,
      discountedTotal: product.price!,
      thumbnail: product.thumbnail!,
    );

    final result = await _catRepo.addProduct(cartProduct);
    if (result.isSuccess) {
      emit(GetCartItemSuccessState(result.data!));
      emit(AddCartItemSuccessState(cartProduct));
      totalcart = result.data!.total;
    } else {
      emit(GetCartItemErrorState(result.error!));
    }
  }

  void updateProductQuantity(int productId, int quantity) async {
    if (quantity < 1) {
      removeProduct(productId);
      return;
    }
    final result = await _catRepo.updateProductQuantity(productId, quantity);
    if (result.isSuccess) {
      emit(GetCartItemSuccessState(result.data!)); // Emit updated cart state
    } else {
      emit(GetCartItemErrorState(result.error!)); // Handle errors
    }
  }

  void removeProduct(int productId) async {
    final result = await _catRepo.removeProduct(productId);
    if (result.isSuccess) {
      emit(GetCartItemSuccessState(result.data!));
    } else {
      emit(GetCartItemErrorState(result.error!));
    }
  }

  void clearCart() async {
    emit(GetCartItemLoadingState());
    try {
      await _catRepo.clearCart();
      emit(CategoryInitial());
    } catch (e) {
      emit(GetCartItemErrorState('Failed to clear cart.'));
    }
  }

  void setTotalItemBuyNow(total) {
    totalcart = total;
    emit(ItemBuyNow());
  }
}
