import 'package:fibeecomm/core/route/approuter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/CustomButton.dart';
import '../../../core/widgets/dialog.dart';
import '../../cart/logic/card_cubit.dart';
import '../logic/payment_cubit.dart';

class Paymentconsumer extends StatelessWidget {
  Paymentconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final cardCubitInstance = context.read<cardCubit>();
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          DialogManager.showSuccessDialog(
            context: context,
            title: 'Success',
            description: 'Payment successful!',
            onPress: () {
              context.go(ConstantsRoutes.CategoriesPage);
            },
          );
        } else if (state is PaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final total = cardCubitInstance.totalcart;

        if (total == 0.0) {
          return const Center(child: Text("No items in the cart."));
        }
        return CustomButton(
          text: "Continue to Payment",
          onPressed: () {
            final paymentCubit = context.read<PaymentCubit>();
            paymentCubit.makePayment(total); // Amount in cents
          },
        );
      },
    );
  }
}
