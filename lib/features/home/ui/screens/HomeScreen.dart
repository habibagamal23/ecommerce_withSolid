import 'package:fibeecomm/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../widgets/banner.dart';
import '../widgets/home.dart';
import '../widgets/homeproduct.dart';
import '../widgets/tit.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
