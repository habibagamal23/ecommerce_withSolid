part of 'new_adress_cubit.dart';

@immutable
sealed class NewAdressState {}

final class NewAdressInitial extends NewAdressState {}
class AddressLoading extends NewAdressState {}

class AddressLoaded extends NewAdressState {
  final String address;
  AddressLoaded(this.address);
}

class AddressError extends NewAdressState {
  final String error;
  AddressError(this.error);
}