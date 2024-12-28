import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/route/approuter.dart';
import '../../core/widgets/CustomButton.dart';
import 'cartitem.dart';
import 'logic/card_cubit.dart';

class Cartconsumer extends StatelessWidget {
  const Cartconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cardCubit, cardState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetCartItemLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCartItemSuccessState) {
          final cart = state.cart;
          if (cart.products.isEmpty) {
            return const Center(child: Text("Your cart is empty!"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (context, index) {
                    final product = cart.products[index];
                    return Cartitem(product: product);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Total: \$${cart.total.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              CustomButton(
                onPressed: () {
                  context.push(ConstantsRoutes.paymentPage);
                },
                text: "Payment",
              ),
            ],
          );
        } else if (state is GetCartItemErrorState) {
          return Center(child: Text("Error: ${state.error}"));
        }

        return const Center(child: Text("No items found."));
      },
    );
  }
}
