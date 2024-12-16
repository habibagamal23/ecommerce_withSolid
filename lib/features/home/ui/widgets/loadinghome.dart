import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/gridpulider.dart';

class LoadingCategory extends StatelessWidget {
  const LoadingCategory({super.key});

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 200.h,
        child: ReusableGridView(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const ShimmerCategoryItem();
          },
        ));
  }
}

class ShimmerCategoryItem extends StatelessWidget {
  const ShimmerCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 60.h,
            width: 60.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
         SizedBox(height: 8.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 14.h,
            width: 60.w,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
