import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerLoading extends StatelessWidget {
  const ProductShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image placeholder
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Container(
                height: 130.h,
                width: 156.w,
                color: Colors.grey.shade300,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Container(
                    height: 16.h,
                    width: 120.w,
                    color: Colors.grey.shade300,
                  ),

                  SizedBox(height: 2.h),
                  // Price
                  Container(
                    height: 14.h,
                    width: 50.w,
                    color: Colors.grey.shade300,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}