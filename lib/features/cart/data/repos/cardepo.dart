import '../../../../core/network/ApiResult.dart';
import '../../../home/data/models/product.dart';
import '../models/CartListResponse.dart';
import '../models/CartProduct.dart';

// open closed and
abstract class CartRepository {
  Future<ApiResult<Cart>> getCart();
  Future<ApiResult<Cart>> addProduct(CartProduct product);
  Future<ApiResult<Cart>> updateProductQuantity(int productId, int quantity);
  Future<ApiResult<Cart>> removeProduct(int productId);
  Future<void> clearCart();
}
