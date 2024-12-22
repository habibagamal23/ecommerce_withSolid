import 'package:fibeecomm/core/network/ApiResult.dart';

import 'package:fibeecomm/features/Login/data/models/login_response.dart';
import 'package:fibeecomm/features/home/data/models/Category.dart';
import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/apiConsumer.dart';
import '../../../home/data/models/product.dart';
import 'catrepo.dart';

class cartrepoimp extends catrepo {
  final ApiConsumer apiConsumer;

  cartrepoimp(this.apiConsumer);
  @override
  Future<ApiResult<ProductResponse>> getProductWithCategoryName(String categoryName) async{
    try {
      final response = await apiConsumer.get(
        "${ApiConstants.productsbycategory}/${categoryName}",
      );
      return ApiResult.success(ProductResponse.fromJson(response));
    } catch (e) {
      return ApiResult.error('Failed to Login user : ${e.toString()}');
    }
  }
}
