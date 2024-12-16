import 'package:fibeecomm/core/network/ApiResult.dart';

import 'package:fibeecomm/features/Login/data/models/login_response.dart';
import 'package:fibeecomm/features/home/data/models/Category.dart';
import 'package:fibeecomm/features/home/data/models/product.dart';

import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/apiConsumer.dart';
import 'homerepo.dart';

class homerepoimp extends homerepo {
  final ApiConsumer apiConsumer;

  homerepoimp(this.apiConsumer);
  

  @override
  Future<ApiResult<List<String>>> getAllCategories() async{
    try {
      final response = await apiConsumer.get(
        ApiConstants.categoryList,
      );
      return ApiResult.success(List.from(response));
    } catch (e) {
      return ApiResult.error('Failed to Login user : ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<ProductResponse>> getAllProduct()async {
    try {
          final response = await apiConsumer.get(
            ApiConstants.products,
            queryParameters: {
              'sortBy': 'title',
              'order': 'asc',
            },
          );

          return ApiResult.success(ProductResponse.fromJson(response));
        } catch (e) {
          return ApiResult.error('Failed to Login user : ${e.toString()}');
        }
  }
}
