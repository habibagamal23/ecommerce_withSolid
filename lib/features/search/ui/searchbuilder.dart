import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/ui/widgets/product.dart';
import '../logic/search_cubit.dart';

class Searchbuilder extends StatelessWidget {
  const Searchbuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchSuccess) {
          final productsToShow = state.products;
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.5 / 4,
            ),
            itemCount: productsToShow.length,
            itemBuilder: (context, index) {
              final product = productsToShow[index];
              return ProductCard(product: product);
            },
          );
        } else if (state is SearchError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Start typing to search.'));
      },
    );
  }
}
