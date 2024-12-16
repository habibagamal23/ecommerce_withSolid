import '../../../../core/network/ApiResult.dart';
import '../models/Category.dart';
import '../models/product.dart';

// open closed and
abstract class homerepo {
  Future<ApiResult<List<String>>> getAllCategories();
  // Future<ApiResult<List<Product>>> getLimitedSortedProducts();
  Future<ApiResult<ProductResponse>> getAllProduct();


}
