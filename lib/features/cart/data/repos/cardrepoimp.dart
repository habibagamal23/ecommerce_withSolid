import '../../../../core/cachhelper/chachhelpe.dart';
import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/ApiResult.dart';
import '../../../../core/network/apiConsumer.dart';
import '../models/card.dart';
import '../models/pro.dart';
import 'cardepo.dart';

class CardRepoImp extends CartRepository {
  final ApiConsumer apiConsumer;
  final Map<int, CartProduct> _products = {}; // Local product cache
  Cart? _cartCache; // Local cart cache

  CardRepoImp(this.apiConsumer);

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
      // If cache exists, return it directly
      if (_cartCache != null) {
        return ApiResult.success(_cartCache!);
      }

      // Fetch cart from the fake API
      final userId = await _getUserId();
      final response = await apiConsumer.get(
        "https://dummyjson.com/carts/user/$userId",
      );
      final carts = response['carts'] as List?;
      if (carts == null || carts.isEmpty) {
        return ApiResult.error('No carts found for the user.');
      }

      // Update local cache with the API data
      _cartCache = Cart.fromJson(carts[0]);
      for (var product in _cartCache!.products) {
        _products[product.id] = product;
      }

      return ApiResult.success(_cartCache!);
    } catch (e) {
      return ApiResult.error('Failed to fetch cart items: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> addProduct(CartProduct product) async {
    try {
      // Update local cache
      if (_products.containsKey(product.id)) {
        _products[product.id]!.quantity += product.quantity;
      } else {
        _products[product.id] = product;
      }

      _updateCartCache();

      // Simulate API call (not updating the cache with the API response)
      await apiConsumer.post(
        'https://dummyjson.com/carts/add',
        data: {
          "userId": await _getUserId(),
          "products": [
            {
              "id": product.id,
              "quantity": product.quantity,
            }
          ],
        },
      );

      return ApiResult.success(_cartCache!);
    } catch (e) {
      return ApiResult.error('Failed to add product: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> updateProductQuantity(
      int productId, int quantity) async {
    try {
      // Remove product if quantity <= 0
      if (quantity <= 0) {
        return await removeProduct(productId);
      }

      // Update local cache
      if (_products.containsKey(productId)) {
        _products[productId]!.quantity = quantity;
      } else {
        return ApiResult.error('Product not found in cart.');
      }

      _updateCartCache();

      // Simulate API call (not updating the cache with the API response)
      await apiConsumer.put(
        'https://dummyjson.com/carts/1',
        data: {
          'merge': true,
          'products': [
            {"id": productId, "quantity": quantity},
          ],
        },
      );

      return ApiResult.success(_cartCache!);
    } catch (e) {
      return ApiResult.error(
          'Failed to update product quantity: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Cart>> removeProduct(int productId) async {
    try {
      // Remove from local cache
      _products.remove(productId);

      _updateCartCache();

      // Simulate API call (not updating the cache with the API response)
      await apiConsumer.put(
        'https://dummyjson.com/carts/1',
        data: {
          'merge': true,
          'products': [
            {"id": productId, "quantity": 0},
          ],
        },
      );

      return ApiResult.success(_cartCache!);
    } catch (e) {
      return ApiResult.error('Failed to remove product: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      // Clear local cache
      _products.clear();
      _cartCache = null;

      // Simulate API call
      await apiConsumer.delete("https://dummyjson.com/carts/1");
    } catch (e) {
      throw Exception('Failed to clear cart: ${e.toString()}');
    }
  }

  // Helper function to update the local cart cache
  void _updateCartCache() {
    double total = 0;
    double discountedTotal = 0;

    for (var product in _products.values) {
      total += product.price * product.quantity;
      discountedTotal += product.discountedTotal * product.quantity;
    }

    _cartCache = Cart(
      id: 1, // Assuming a single cart
      products: _products.values.toList(),
      total: total,
      discountedTotal: discountedTotal,
      userId: 1, // Replace with dynamic user ID if needed
      totalProducts: _products.length,
      totalQuantity:
          _products.values.fold(0, (sum, item) => sum + item.quantity),
    );
  }
}
