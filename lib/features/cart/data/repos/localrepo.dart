import '../../../../core/network/ApiResult.dart';
import '../models/CartListResponse.dart';
import '../models/CartProduct.dart';
import 'cardepo.dart';

class CartCache {
  final Map<int, CartProduct> _localCache = {};
  Cart? _cartCache;

  Cart? get cart => _cartCache;

  Map<int, CartProduct> get products => _localCache;

  void updateCart(Cart cart) {
    _cartCache = cart;
    _localCache.clear();
    for (var product in cart.products) {
      _localCache[product.id] = product;
    }
  }


  void  addProduct(CartProduct product)  {
    if (_localCache.containsKey(product.id)) {
      _localCache[product.id]!.quantity += product.quantity;
    } else {
      _localCache[product.id!] = product;
    }
    _refreshCartCache();
  }


  void updateProduct(int productId, int quantity) {
    if (_localCache.containsKey(productId)) {
      if (quantity > 0) {
        _localCache[productId]!.quantity = quantity;
      } else {
        _localCache.remove(productId);
      }
    }
    _refreshCartCache();
  }


  void removeProduct(int productId) {
    _localCache.remove(productId);
    _refreshCartCache();
  }

  void clearCache() {
    _localCache.clear();
    _cartCache = null;
  }

  void _refreshCartCache() {
    final products = _localCache.values.toList();
    final total = products.fold(0.0, (sum, p) => sum + (p.price * p.quantity));
    final discountedTotal = products.fold(
      0.0,
      (sum, p) => sum + (p.discountedTotal * p.quantity),
    );

    _cartCache = Cart(
      id: 1,
      userId: 1,
      products: products,
      total: total,
      discountedTotal: discountedTotal,
      totalProducts: products.length,
      totalQuantity: products.fold(0, (sum, p) => sum + p.quantity),
    );
  }
}

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
        userId: 1,
        totalProducts: _products.length,
        totalQuantity:
            _products.values.fold(0, (sum, item) => sum + item.quantity),
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
  Future<ApiResult<Cart>> updateProductQuantity(
      int productId, int quantity) async {
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
