import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/card_cubit.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: BlocConsumer<cardCubit, cardState>(
        listener: (context, state) {
         if (state is UpdateItemCountSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cart updated successfully!")),
            );
          }
        },
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
                      return ListTile(
                        leading: Image.network(
                          product.thumbnail!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title),
                        subtitle: Text("Price: \$${product.price}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                context
                                    .read<cardCubit>()
                                    .updateProductQuantity(product.id, product.quantity - 1);
                              },
                            ),
                            Text("${product.quantity}"),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context
                                    .read<cardCubit>()
                                    .updateProductQuantity(product.id, product.quantity + 1);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Total: \$${cart.total.toStringAsFixed(2)}",
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Proceeding to payment...")),
                          );
                        },
                        child: const Text("Proceed to Payment"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is GetCartItemErrorState) {
            return Center(child: Text("Error: ${state.error}"));
          }

          return const Center(child: Text("No items found."));
        },
      ),
    );
  }
}
