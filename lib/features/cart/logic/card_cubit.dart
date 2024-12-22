import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../home/data/models/product.dart';
import '../data/models/card.dart';
import '../data/models/pro.dart';
import '../data/repos/cardepo.dart';

part 'card_state.dart';

class cardCubit extends Cubit<cardState> {
  final CartRepository _catRepo;

  cardCubit(this._catRepo) : super(CategoryInitial());

  void getCart() async {
    emit(GetCartItemLoadingState());
    final result = await _catRepo.getCart();
    if (result.isSuccess) {
        emit(GetCartItemSuccessState(result.data!));
    } else {
      emit(GetCartItemErrorState(result.error!));
    }
  }

  void addProduct(CartProduct product) async {
    final result = await _catRepo.addProduct(product);
    if (result.isSuccess) {
      //        emit(GetCartItemSuccessState(result.data!)); or // call fun get
      emit(GetCartItemSuccessState(result.data!));
      emit(AddCartItemSuccessState(result.data!));

    } else {
      emit(GetCartItemErrorState(result.error!));
    }
  }

  void updateProductQuantity(int productId, int quantity) async {
    final result = await _catRepo.updateProductQuantity(productId, quantity);
    if (result.isSuccess) {
      emit(UpdateItemCountSuccessState(result.data!));
      getCart();
    } else {
      emit(GetCartItemErrorState(result.error!));
    }
  }

}
