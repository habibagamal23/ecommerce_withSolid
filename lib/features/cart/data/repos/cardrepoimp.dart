import 'package:fibeecomm/features/cart/data/repos/localrepo.dart';

import '../../../../core/cachhelper/chachhelpe.dart';
import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/ApiResult.dart';
import '../../../../core/network/apiConsumer.dart';
import '../models/CartListResponse.dart';
import '../models/CartProduct.dart';
import 'cardepo.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiConsumer apiConsumer;
  final CartCache cartCache;

  CartRepositoryImpl(this.apiConsumer, this.cartCache);

  Future<int> _getUserId() async {
    final userId = await SharedPreferencesHelper.getId();
    if (userId == null) {
      throw Exception('User ID is missing from SharedPreferences.');
    }
    return userId;
  }

  @override
  Future<ApiResult<Cart>> getCart() async {
    try {
      if (cartCache.cart != null) {
        return ApiResult.success(cartCache.cart!);
      }

      final response = await apiConsumer.get("https://dummyjson.com/carts/1");
      if (response != null) {
        final cart = Cart.fromJson(response);
        cartCache.updateCart(cart);
        return ApiResult.success(cart);
      }

      return ApiResult.error('No cart data found.');
    } catch (e) {
      return ApiResult.error('Failed to fetch cart: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> addProduct(CartProduct product) async {
    try {
      cartCache.addProduct(product);
      await apiConsumer.post(
        'https://dummyjson.com/carts/add',
        data: {
          "userId": await _getUserId(),
          "products": [
            {"id": product.id, "quantity": product.quantity},
          ],
        },
      );

      return ApiResult.success(cartCache.cart!);
    } catch (e) {
      return ApiResult.error('Failed to add product: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> updateProductQuantity(int productId, int quantity) async {
    try {
      if (quantity <= 0) {
        return await removeProduct(productId);
      }
        cartCache.updateProduct( productId,  quantity); // Update local cache
      await apiConsumer.put(
        'https://dummyjson.com/carts/1',
        data: {
          'merge': true,
          'products': [
            {"id": productId, "quantity": quantity},
          ],
        },
      );

      return ApiResult.success(cartCache.cart!);
    } catch (e) {
      return ApiResult.error('Failed to update product: ${e.toString()}');
    }
  }


  @override
  Future<ApiResult<Cart>> removeProduct(int productId) async {
    try {
      cartCache.removeProduct(productId);
      await apiConsumer.put(
        'https://dummyjson.com/carts/1',
        data: {
          'merge': true,
          'products': [
            {"id": productId, "quantity": 0},
          ],
        },
      );

      return ApiResult.success(cartCache.cart!);
    } catch (e) {
      return ApiResult.error('Failed to remove product: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      cartCache.clearCache();

      await apiConsumer.delete("https://dummyjson.com/carts/1");
    } catch (e) {
      throw Exception('Failed to clear cart: ${e.toString()}');
    }
  }
}
