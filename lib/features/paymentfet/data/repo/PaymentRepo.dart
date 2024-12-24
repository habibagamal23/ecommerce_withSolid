import 'package:fibeecomm/core/network/ApiResult.dart';

import '../models/PaymentIntentInputModel.dart';
import '../models/PaymentIntentModel.dart';

abstract class PaymentRepo {
  Future<ApiResult<PaymentIntentResponse>> createPaymentIntent(
      PaymentIntentInputModel input);
  Future<void> initPaymentSheet(
      String clientSecret );
  Future<void> displayPaymentSheet();

}
