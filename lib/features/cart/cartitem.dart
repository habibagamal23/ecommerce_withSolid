import 'package:fibeecomm/features/cart/data/models/pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/card_cubit.dart';

class Cartitem extends StatelessWidget {
  CartProduct product;
  Cartitem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
  }
}
