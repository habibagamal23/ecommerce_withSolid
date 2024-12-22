
import 'package:fibeecomm/core/styles/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/route/approuter.dart';
import '../../../categoreis/logic/category_cubit.dart';


class CategoryItem extends StatelessWidget {
  final String category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final productCubit = context.read<CategoryCubit>();
        productCubit.fetchProductsByCategory(category);
        context.push(ConstantsRoutes.CategoryProductsScreen, extra: category);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent.withOpacity(0.2),
            ),
            child: Center(
              child: Text(
                category[0].toUpperCase(),
                style:  TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.mainBlue,
                ),
              ),
            ),
          ),
           SizedBox(height: 8.h),
          Text(
            category,
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
