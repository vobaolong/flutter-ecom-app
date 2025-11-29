import 'package:get_storage/get_storage.dart';

/// Storage Service - Tương tự localStorage trong web
/// Quản lý tất cả việc lưu trữ dữ liệu local trong app
/// Singleton pattern để đảm bảo chỉ có một instance
class StorageService {
  static final GetStorage _storage = GetStorage();
  static StorageService? _instance;

  // Private constructor
  StorageService._();

  // Factory constructor để đảm bảo singleton
  factory StorageService() {
    _instance ??= StorageService._();
    return _instance!;
  }

  // Keys cho các loại dữ liệu
  static const String _keyIsFirstTime = 'isFirstTime';
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyIsDarkMode = 'isDarkMode';
  static const String _keyAddresses = 'addresses';
  static const String _keyPaymentMethods = 'paymentMethods';
  static const String _keyNotifications = 'notificationSettings';
  static const String _keyOrders = 'orders';
  static const String _keyCart = 'cart';
  static const String _keyWishlist = 'wishlist';
  static const String _keyUserProfile = 'userProfile';

  // ============ Auth & App Settings ============

  bool get isFirstTime => _storage.read(_keyIsFirstTime) ?? true;
  set isFirstTime(bool value) => _storage.write(_keyIsFirstTime, value);

  bool get isLoggedIn => _storage.read(_keyIsLoggedIn) ?? false;
  set isLoggedIn(bool value) => _storage.write(_keyIsLoggedIn, value);

  bool get isDarkMode => _storage.read(_keyIsDarkMode) ?? false;
  set isDarkMode(bool value) => _storage.write(_keyIsDarkMode, value);

  // ============ User Profile ============

  Map<String, dynamic>? get userProfile => _storage.read(_keyUserProfile);
  void saveUserProfile(Map<String, dynamic> profile) {
    _storage.write(_keyUserProfile, profile);
  }

  void clearUserProfile() {
    _storage.remove(_keyUserProfile);
  }

  // ============ Addresses ============

  List<Map<String, dynamic>> getAddresses() {
    final data = _storage.read(_keyAddresses);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data);
  }

  void saveAddresses(List<Map<String, dynamic>> addresses) {
    _storage.write(_keyAddresses, addresses);
  }

  void addAddress(Map<String, dynamic> address) {
    final addresses = getAddresses();
    addresses.add(address);
    saveAddresses(addresses);
  }

  void updateAddress(int id, Map<String, dynamic> updatedAddress) {
    final addresses = getAddresses();
    final index = addresses.indexWhere((a) => a['id'] == id);
    if (index != -1) {
      addresses[index] = updatedAddress;
      saveAddresses(addresses);
    }
  }

  void deleteAddress(int id) {
    final addresses = getAddresses();
    addresses.removeWhere((a) => a['id'] == id);
    saveAddresses(addresses);
  }

  // ============ Payment Methods ============

  List<Map<String, dynamic>> getPaymentMethods() {
    final data = _storage.read(_keyPaymentMethods);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data);
  }

  void savePaymentMethods(List<Map<String, dynamic>> methods) {
    _storage.write(_keyPaymentMethods, methods);
  }

  void addPaymentMethod(Map<String, dynamic> method) {
    final methods = getPaymentMethods();
    methods.add(method);
    savePaymentMethods(methods);
  }

  void deletePaymentMethod(int id) {
    final methods = getPaymentMethods();
    methods.removeWhere((m) => m['id'] == id);
    savePaymentMethods(methods);
  }

  // ============ Notification Settings ============

  Map<String, dynamic> getNotificationSettings() {
    final data = _storage.read(_keyNotifications);
    if (data == null) {
      // Default settings
      return {
        'orderNotifications': true,
        'promotionNotifications': true,
        'paymentNotifications': true,
        'deliveryNotifications': true,
        'emailNotifications': false,
        'pushNotifications': true,
        'smsNotifications': false,
      };
    }
    return Map<String, dynamic>.from(data);
  }

  void saveNotificationSettings(Map<String, dynamic> settings) {
    _storage.write(_keyNotifications, settings);
  }

  // ============ Orders ============

  List<Map<String, dynamic>> getOrders() {
    final data = _storage.read(_keyOrders);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data);
  }

  void saveOrders(List<Map<String, dynamic>> orders) {
    _storage.write(_keyOrders, orders);
  }

  void addOrder(Map<String, dynamic> order) {
    final orders = getOrders();
    orders.insert(0, order); // Add to beginning
    saveOrders(orders);
  }

  // ============ Cart ============

  List<Map<String, dynamic>> getCart() {
    final data = _storage.read(_keyCart);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data);
  }

  void saveCart(List<Map<String, dynamic>> cart) {
    _storage.write(_keyCart, cart);
  }

  // ============ Wishlist ============

  List<int> getWishlist() {
    final data = _storage.read(_keyWishlist);
    if (data == null) return [];
    return List<int>.from(data);
  }

  void saveWishlist(List<int> productIds) {
    _storage.write(_keyWishlist, productIds);
  }

  void addToWishlist(int productId) {
    final wishlist = getWishlist();
    if (!wishlist.contains(productId)) {
      wishlist.add(productId);
      saveWishlist(wishlist);
    }
  }

  void removeFromWishlist(int productId) {
    final wishlist = getWishlist();
    wishlist.remove(productId);
    saveWishlist(wishlist);
  }

  bool isInWishlist(int productId) {
    return getWishlist().contains(productId);
  }

  // ============ Utility Methods ============

  /// Xóa tất cả dữ liệu (dùng khi logout)
  void clearAll() {
    _storage.remove(_keyIsLoggedIn);
    _storage.remove(_keyUserProfile);
    _storage.remove(_keyCart);
    // Giữ lại addresses, payment methods, orders nếu muốn
    // Hoặc xóa hết nếu muốn reset hoàn toàn
  }

  /// Xóa một key cụ thể
  void remove(String key) {
    _storage.remove(key);
  }

  /// Đọc giá trị generic
  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Ghi giá trị generic
  void write(String key, dynamic value) {
    _storage.write(key, value);
  }
}
