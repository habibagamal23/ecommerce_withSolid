import '../../../../core/network/ApiResult.dart';
import '../models/card.dart';
import '../models/pro.dart';
import 'cardepo.dart';

class LocalCartRepository implements CartRepository {
  final Map<int, CartProduct> _products = {};

  @override
  Future<ApiResult<Cart>> getCart() async {
    double total = 0;
    double discountedTotal = 0;

    for (var product in _products.values) {
      total += product.price * product.quantity;
      discountedTotal += product.discountedTotal * product.quantity;
    }

    return ApiResult.success(
      Cart(
        id: 1,
        products: _products.values.toList(),
        total: total,
        discountedTotal: discountedTotal,
        userId: 1, // Fixed for testing
        totalProducts: _products.length,
        totalQuantity: _products.values.fold(0, (sum, item) => sum + item.quantity),
      ),
    );
  }

  @override
  Future<ApiResult<Cart>> addProduct(CartProduct product) async {
    if (_products.containsKey(product.id)) {
      _products[product.id]!.quantity += product.quantity;
    } else {
      _products[product.id!] = product;
    }
    return getCart();
  }

  @override
  Future<ApiResult<Cart>> updateProductQuantity(int productId, int quantity) async {
    if (_products.containsKey(productId)) {
      if (quantity > 0) {
        _products[productId]!.quantity = quantity;
      } else {
        _products.remove(productId);
      }
    }
    return getCart();
  }

  @override
  Future<ApiResult<Cart>> removeProduct(int productId) async {
    _products.remove(productId);
    return getCart();
  }

  @override
  Future<void> clearCart() async {
    _products.clear();

  }
}
