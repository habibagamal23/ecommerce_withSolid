import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../home/data/models/product.dart';
import '../data/repos/catrepo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final catrepo _catRepo;

  CategoryCubit(this._catRepo) : super(CategoryInitial());
  Map<String, List<Product>> categoryProductCache = {};

  Future<void> fetchProductsByCategory(String categoryName) async {
    if (categoryProductCache.containsKey(categoryName)) {
      return;
    }
    emit(CategoryLoading());
    try {
      final result = await _catRepo.getProductWithCategoryName(categoryName);
      if (result.isSuccess) {
        categoryProductCache[categoryName] = result.data!.products!;
        emit(CategorySuccess(categoryProductCache[categoryName]!));
      } else {
        emit(CategoryError(result.error!));
      }
    } catch (e) {
      emit(CategoryError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
