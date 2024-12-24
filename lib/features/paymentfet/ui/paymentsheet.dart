import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/CustomButton.dart';
import '../../../core/widgets/dialog.dart';
import '../logic/payment_cubit.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  double amount;
  PaymentMethodsBottomSheet({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 17),
          const PaymentMethodsListView(),
          SizedBox(height: 32),
          BlocConsumer<PaymentCubit, PaymentState>(builder: (context, state) {
            if (state is PaymentLoading) {
              return CircularProgressIndicator();
            }
            return CustomButton(
                text: "Contanui",
                onPressed: () {
                  final paymentCubit = context.read<PaymentCubit>();
                  paymentCubit.makePayment(amount);
                });
          }, listener: (context, state) {
            if (state is PaymentSuccess) {
              DialogManager.showSuccessDialog(
                context: context,
                title: 'succes',
                description: 'Succes pyment',
                onPress: () {
                  context.pop();
                },
              );
            }
            if (state is PaymentError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          })
        ],
      ),
    );
  }
}

class PaymentMethodsListView extends StatelessWidget {
  const PaymentMethodsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: PaymentMethodItem(
        image: "assets/images/card.svg",
        isActive: true,
      ),
    );
  }
}

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.isActive,
    required this.image,
  });

  final bool isActive;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 103,
      height: 62,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.50,
            color: isActive ? const Color(0xFF34A853) : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: isActive ? const Color(0xFF34A853) : Colors.white,
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Center(
          child: SvgPicture.asset(
            image,
          ),
        ),
      ),
    );
  }
}
