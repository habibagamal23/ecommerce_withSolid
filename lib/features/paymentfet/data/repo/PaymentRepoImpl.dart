import 'package:dio/dio.dart';
import 'package:fibeecomm/core/network/ApiResult.dart';

import 'package:fibeecomm/features/paymentfet/data/models/PaymentIntentInputModel.dart';

import 'package:fibeecomm/features/paymentfet/data/models/PaymentIntentModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/apiConsumer.dart';
import 'PaymentRepo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final ApiConsumer apiConsumer;

  PaymentRepoImpl(this.apiConsumer);

  @override
  Future<ApiResult<PaymentIntentResponse>> createPaymentIntent(
      PaymentIntentInputModel input) async {
    try {
      final response = await apiConsumer.post(
        ApiConstants.urlStripCreatePayment,
        data: input.toJson(),
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Bearer ${ApiConstants.tokenStripe}'}),
      );
      return ApiResult.success(PaymentIntentResponse.fromJson(response));
    } catch (e) {
      return ApiResult.error('Failed to create payment intent: $e');
    }
  }

  @override
  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  @override
  Future<void> initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Store',
          appearance: PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
            background: Colors.lightBlue,
            primary: Colors.blue,
            componentBorder: Colors.red,
          ))),
    );
  }
}
