import 'package:fibeecomm/features/categoreis/logic/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/ui/widgets/product.dart';
import '../../home/ui/widgets/productShimmmer.dart';
class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(categoryName),
            floating: true,
            pinned: true,
            expandedHeight: 80.0,
            backgroundColor: Colors.red,
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 2.5 / 4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => const ProductShimmerLoading(),
                      childCount: 4,
                    ),
                  ),
                );
              }
              if (state is CategorySuccess) {
                // Display the actual product grid
                return SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final product = state.productResponse[index];
                        return ProductCard(product: product);
                      },
                      childCount: state.productResponse.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2.5 / 4,
                    ),
                  ),
                );
              } else if (state is CategoryError) {
                // Error message
                return SliverFillRemaining(
                  child: Center(child: Text(state.message)),
                );
              } else {
                return const SliverFillRemaining(
                  child: Center(child: Text("No products available")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}