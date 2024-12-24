part of 'adress_cubit.dart';

@immutable
sealed class AdressState {}

final class AdressInitial extends AdressState {}
class AddressLoading extends AdressState {}

class AddressLoaded extends AdressState {
  final String address;
  AddressLoaded(this.address);
}

class AddressError extends AdressState {
  final String error;
  AddressError(this.error);
}
