import '../../../../core/network/ApiResult.dart';
import '../../../home/data/models/product.dart';
import '../models/Category.dart';

// open closed and
abstract class catrepo {
  Future<ApiResult<ProductResponse>> getProductWithCategoryName(String categoryName)  ;
}
