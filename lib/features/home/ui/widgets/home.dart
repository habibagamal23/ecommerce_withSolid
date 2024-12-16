import 'package:fibeecomm/features/home/ui/widgets/loadinghome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/gridpulider.dart';
import '../../data/models/Category.dart';
import '../../logic/home_cubit.dart';
import 'CategoryItem.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const LoadingCategory();
        } else if (state is HomeSucces) {
          final categories = state.catigoris;
          return SizedBox(
              height: 200.h,
              child: ReusableGridView(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                childAspectRatio: 0.58.sp,
                padding: EdgeInsets.zero,
                mainAxisSpacing: 2.sp,
                crossAxisSpacing: 0.sp,
                itemBuilder: (context, index) {
                  return CategoryItem(category: categories[index]);
                },
              ));
        } else if (state is HomeErorr) {
          return Center(child: Text('Error: ${state.msg}'));
        } else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }
}
