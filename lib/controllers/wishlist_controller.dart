import 'package:flutter_ecom_app/models/products.dart';
import 'package:flutter_ecom_app/services/storage_service.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final StorageService _storage = StorageService();
  final RxList<int> _wishlistIds = <int>[].obs;

  List<int> get wishlistIds => _wishlistIds;
  List<Product> get wishlistProducts {
    return products
        .where((product) => _wishlistIds.contains(product.id))
        .toList();
  }

  bool isInWishlist(int productId) {
    return _wishlistIds.contains(productId);
  }

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }

  void _loadWishlist() {
    _wishlistIds.value = _storage.getWishlist();
  }

  void toggleWishlist(int productId) {
    if (_wishlistIds.contains(productId)) {
      removeFromWishlist(productId);
    } else {
      addToWishlist(productId);
    }
  }

  void addToWishlist(int productId) {
    if (!_wishlistIds.contains(productId)) {
      _wishlistIds.add(productId);
      _storage.addToWishlist(productId);
      update();
    }
  }

  void removeFromWishlist(int productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
      _storage.removeFromWishlist(productId);
      update();
    }
  }

  void clearWishlist() {
    _wishlistIds.clear();
    _storage.saveWishlist([]);
    update();
  }
}
