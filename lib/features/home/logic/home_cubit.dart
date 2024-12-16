import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/cachhelper/chachhelpe.dart';
import '../data/models/Category.dart';
import '../data/models/product.dart';
import '../data/repos/homerepo.dart';

part 'home_State.dart';

class HomeCubit extends Cubit<HomeState> {
  final homerepo homerepoo;
  HomeCubit(this.homerepoo) : super(HomeInitial());

  List<String> categories = [];
  List<Product> products = [];
  Future<void> loginUser() async {
    if (categories.isNotEmpty && products.isNotEmpty) {
      return;
    }
    emit(HomeLoading());
    try {
      final result = await homerepoo.getAllCategories();
      final result2 = await homerepoo.getAllProduct();
      if (result.isSuccess && result2.isSuccess) {
        categories = result.data!;
        products = result2.data!.products!;
        emit(HomeSucces(categories, products));
      } else {
        emit(HomeErorr(result.error!));
      }
    } catch (e) {
      emit(HomeErorr("Error Home ${e.toString()}"));
    }
  }
}
