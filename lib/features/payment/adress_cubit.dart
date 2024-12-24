import 'package:bloc/bloc.dart';
import 'package:fibeecomm/features/payment/repo/addrepo.dart';
import 'package:meta/meta.dart';

part 'adress_state.dart';

class AdressCubit extends Cubit<AdressState> {
  final IAddressRepository repository;
  AdressCubit(this.repository) : super(AdressInitial());

  Future<void> fetchAddress() async {
    emit(AddressLoading());
    try {
      final address = await repository.getCurrentAddress();
      emit(AddressLoaded(address));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
  void updateAddress(String newAddress) {
    emit(AddressLoaded(newAddress));
  }
}
