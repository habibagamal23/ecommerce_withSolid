import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/ApiResult.dart';
import '../../../../core/network/apiConsumer.dart';
import '../../../home/data/models/product.dart';

abstract class SearchRepo {
  Future<ApiResult<ProductResponse>> Searchproduct(quary);
}

class SearchRepoImp extends SearchRepo {
  final ApiConsumer apiConsumer;

  SearchRepoImp(this.apiConsumer);

  @override
  Future<ApiResult<ProductResponse>> Searchproduct(quary) async {
    try {
      final response = await apiConsumer.get(
        "${ApiConstants.products}/search",
        queryParameters: {'q': quary},
      );
      return ApiResult.success(ProductResponse.fromJson(response));
    } catch (e) {
      return ApiResult.error('Failed to Login user : ${e.toString()}');
    }
  }
}
