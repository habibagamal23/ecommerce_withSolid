import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'renew.dart';

part 'new_adress_state.dart';

class NewAdressCubit extends Cubit<NewAdressState> {
  NewAdressCubit(this.locationService) : super(NewAdressInitial());
  final ILocationService locationService;

  Future<void> fetchAddress() async {
    emit(AddressLoading());
    try {
      final position = await locationService.getCurrentPosition();
      final address = await locationService.getAddressFromCoordinates(
          position.latitude, position.longitude);
      emit(AddressLoaded(address));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  void updateAddress(String newAddress) {
    emit(AddressLoaded(newAddress));
  }
}
