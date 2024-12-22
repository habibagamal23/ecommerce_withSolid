import 'package:fibeecomm/core/route/approuter.dart';
import 'package:fibeecomm/core/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/logic/card_cubit.dart';
import '../widgets/banner.dart';
import '../widgets/home.dart';
import '../widgets/homeproduct.dart';
import '../widgets/tit.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context
                  .read<cardCubit>()
                  .getCart();
            context.push(ConstantsRoutes.cart);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(40),
            Text("Home"),
            verticalSpace(40),
            const BannerCarouselSlider(),
            verticalSpace(40),
            CategoriesPage(),
            TitleWithActions(
              title:"New Arrivls",
              onviewPressed: () {},
            ),
            const TopHomeProduct(),
          ],
        ),
      ),
    );
  }
}
