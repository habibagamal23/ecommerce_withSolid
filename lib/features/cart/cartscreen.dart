import 'package:fibeecomm/core/network/ApiConstants.dart';
import 'package:fibeecomm/core/route/approuter.dart';
import 'package:fibeecomm/features/cart/cartitem.dart';
import 'package:fibeecomm/features/paymentfet/ui/paymentconsumer.dart';
import 'package:fibeecomm/features/paymentfet/ui/paymentsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/CustomButton.dart';
import '../paymentfet/logic/payment_cubit.dart';
import 'cartconsumer.dart';
import 'logic/card_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Cart"),
        ),
        body: Cartconsumer());
  }
}
