import '../../../../core/cachhelper/chachhelpe.dart';
import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/ApiResult.dart';
import '../../../../core/network/apiConsumer.dart';
import '../models/card.dart';
import '../models/pro.dart';
import 'cardepo.dart';

class CardRepoImp extends CartRepository {
  final ApiConsumer apiConsumer;

  CardRepoImp(this.apiConsumer);

  Future<int> _getUserId() async {
    final userId = await SharedPreferencesHelper.getId();
    if (userId == null) {
      throw Exception('User ID is missing from SharedPreferences.');
    }
    return userId;
  }

  @override
  Future<ApiResult<Cart>> addProduct(CartProduct product) async {
    try {
      final userId = await _getUserId();
      final response = await apiConsumer.post(
        'https://dummyjson.com/carts/add',
        data: {
          "userId": userId,
          "products": [
            {
              "id": product.id,
              "quantity": product.quantity,
            }
          ],
        },
      );
      return ApiResult.success(Cart.fromJson(response));
    } catch (e) {
      return ApiResult.error('Unexpected Error: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> getCart() async {
    try {
      final userId = await _getUserId();
      final response = await apiConsumer.get(
        "https://dummyjson.com/carts/user/$userId",
      );
      final carts = response['carts'] as List?;
      if (carts == null || carts.isEmpty) {
        return ApiResult.error('No carts found for the user.');
      }
      return ApiResult.success(Cart.fromJson(carts[0]));
    } catch (e) {
      return ApiResult.error('Failed to fetch cart items: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> updateProductQuantity(int productId, int quantity) async {
    try {
      final response = await apiConsumer.put(
        'https://dummyjson.com/carts/1',
        data: {
          'merge': true,
          'products': [
            {"id": productId, "quantity": quantity},
          ],
        },
      );
      return ApiResult.success(Cart.fromJson(response));
    } catch (e) {
      return ApiResult.error('Failed to update item count in cart: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> removeProduct(int productId) async {
    try {
      final response = await apiConsumer.put(
        'https://dummyjson.com/carts/1',
        data: {
          'merge': true,
          'products': [
            {"id": productId, "quantity": 0},
          ],
        },
      );
      return ApiResult.success(Cart.fromJson(response));
    } catch (e) {
      return ApiResult.error('Failed to remove product from cart: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCart() async{
    try {
      await apiConsumer.delete("https://dummyjson.com/carts/1");
    } catch (e) {
     throw Exception(e.toString());
    }
  }


}
