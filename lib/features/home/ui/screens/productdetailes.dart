import 'package:easy_localization/easy_localization.dart';
import 'package:fibeecomm/core/route/approuter.dart';
import 'package:fibeecomm/core/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/CustomButton.dart';
import '../../../cart/data/models/pro.dart';
import '../../../cart/logic/card_cubit.dart';
import '../../data/models/product.dart';
import '../widgets/pro/im.dart';
import '../widgets/pro/info.dart';
import '../widgets/pro/nam.dart';
import '../widgets/pro/review.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageViewer(images: product.images!),
            verticalSpace(20),
            NameRating(
              product: product,
            ),
            verticalSpace(20),
            ProductInfoSection(product: product),
            verticalSpace(20),
            Text('Description', style: Theme.of(context).textTheme.titleSmall),
            Text(product.description ?? 'No description available'),
            verticalSpace(20),
            ReviewSection(reviews: product.reviews!),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.grey),
            iconSize: 24.sp,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomButton(
                  text: "Buy Now",
                  onPressed: () {
                    context.push(ConstantsRoutes.paymentPage);
                  }),
            ),
          ),
          BlocListener<cardCubit, cardState>(
            listener: (context, state) {
              if (state is AddCartItemSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Added to cart successfully!" )));
              }
            },
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CustomButton(
                  text: "Add to cart",
                  onPressed: () {
                    final cartProduct = CartProduct(
                      id: product.id!,
                      title: product.title!,
                      price: product.price!,
                      quantity: 1,
                      total: product.price!,
                      discountPercentage: product.discountPercentage!,
                      discountedTotal: product.price!,
                      thumbnail: product.thumbnail!,
                    );
                    final cartCubit = context.read<cardCubit>();
                    cartCubit.addProduct(cartProduct);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
