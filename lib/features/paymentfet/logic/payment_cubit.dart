import 'package:bloc/bloc.dart';
import 'package:fibeecomm/features/paymentfet/data/repo/PaymentRepo.dart';
import 'package:meta/meta.dart';

import '../data/models/PaymentIntentInputModel.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  Future<void> makePayment(double amount) async {
    emit(PaymentLoading());
    try {
      PaymentIntentInputModel input = PaymentIntentInputModel(
        amount: amount.toInt(),
        currency: 'usd',
      );
      final result = await paymentRepo.createPaymentIntent(input);
      if (result.isSuccess) {
        await paymentRepo.initPaymentSheet(result.data!.clientSecret!);
        await paymentRepo.displayPaymentSheet();
        emit(PaymentSuccess());
      } else {
        emit(PaymentError(result.error!));
      }
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
