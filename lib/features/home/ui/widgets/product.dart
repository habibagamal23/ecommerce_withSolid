import 'package:fibeecomm/core/route/approuter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(ConstantsRoutes.productPage, extra: product);
      },
      child: Container(
        width: 180.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProductImage(),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProductTitle(context),
                  SizedBox(height: 2.h),
                  _buildProductPrice(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      child: Image.network(
        product.images![0],
        height: 170.h,
        width: 156.w,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) =>
             Icon(Icons.error, size: 40.sp),
      ),
    );
  }

  Widget _buildProductTitle(BuildContext context) {
    return Text(
      product.title ?? "no title",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductPrice() {
    return Text(
      '${product.price} \$',
      style: TextStyle(
          fontSize: 12.sp, fontWeight: FontWeight.bold,
          color: Colors.black),
      overflow: TextOverflow.ellipsis,
    );
  }
}
