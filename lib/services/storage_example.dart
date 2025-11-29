/// Ví dụ sử dụng StorageService
/// File này chỉ để tham khảo, không cần import vào app

import 'package:flutter_ecom_app/services/storage_service.dart';

class StorageExample {
  final StorageService storage = StorageService();

  // ============ Ví dụ 1: Lưu và đọc settings ============
  void example1_Settings() {
    // Lưu settings
    storage.isLoggedIn = true;
    storage.isDarkMode = true;
    storage.isFirstTime = false;

    // Đọc settings
    bool isLoggedIn = storage.isLoggedIn;
    bool isDarkMode = storage.isDarkMode;
    print('User logged in: $isLoggedIn');
    print('Dark mode: $isDarkMode');
  }

  // ============ Ví dụ 2: Lưu và đọc user profile ============
  void example2_UserProfile() {
    // Lưu profile
    storage.saveUserProfile({
      'name': 'John Doe',
      'email': 'john@example.com',
      'phone': '+1 234 567 8900',
      'avatar': 'assets/images/avatar.jpg',
    });

    // Đọc profile
    final profile = storage.userProfile;
    if (profile != null) {
      print('User name: ${profile['name']}');
      print('User email: ${profile['email']}');
    }

    // Xóa profile khi logout
    storage.clearUserProfile();
  }

  // ============ Ví dụ 3: Quản lý địa chỉ ============
  void example3_Addresses() {
    // Thêm địa chỉ mới
    storage.addAddress({
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': 'John Doe',
      'phone': '+1 234 567 8900',
      'address': '123 Main Street',
      'city': 'New York',
      'state': 'NY',
      'zipCode': '10001',
      'isDefault': true,
    });

    // Lấy tất cả địa chỉ
    List<Map<String, dynamic>> addresses = storage.getAddresses();
    print('Total addresses: ${addresses.length}');

    // Cập nhật địa chỉ
    if (addresses.isNotEmpty) {
      final firstAddress = addresses.first;
      firstAddress['city'] = 'Los Angeles';
      storage.updateAddress(firstAddress['id'], firstAddress);
    }

    // Xóa địa chỉ
    if (addresses.isNotEmpty) {
      storage.deleteAddress(addresses.first['id']);
    }
  }

  // ============ Ví dụ 4: Quản lý phương thức thanh toán ============
  void example4_PaymentMethods() {
    // Thêm thẻ mới
    storage.addPaymentMethod({
      'id': DateTime.now().millisecondsSinceEpoch,
      'type': 'card',
      'cardNumber': '**** **** **** 4242',
      'cardHolder': 'John Doe',
      'expiryDate': '12/25',
      'isDefault': true,
    });

    // Lấy tất cả thẻ
    List<Map<String, dynamic>> methods = storage.getPaymentMethods();
    print('Total payment methods: ${methods.length}');

    // Xóa thẻ
    if (methods.isNotEmpty) {
      storage.deletePaymentMethod(methods.first['id']);
    }
  }

  // ============ Ví dụ 5: Cài đặt thông báo ============
  void example5_Notifications() {
    // Lấy settings hiện tại
    Map<String, dynamic> settings = storage.getNotificationSettings();
    print('Order notifications: ${settings['orderNotifications']}');

    // Cập nhật settings
    settings['orderNotifications'] = false;
    settings['emailNotifications'] = true;
    storage.saveNotificationSettings(settings);
  }

  // ============ Ví dụ 6: Quản lý giỏ hàng ============
  void example6_Cart() {
    // Lưu giỏ hàng
    storage.saveCart([
      {'productId': 1, 'quantity': 2, 'price': 99.99},
      {'productId': 3, 'quantity': 1, 'price': 149.99},
    ]);

    // Lấy giỏ hàng
    List<Map<String, dynamic>> cart = storage.getCart();
    print('Cart items: ${cart.length}');

    // Tính tổng
    double total = cart.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
    print('Total: \$$total');
  }

  // ============ Ví dụ 7: Wishlist ============
  void example7_Wishlist() {
    // Thêm vào wishlist
    storage.addToWishlist(1);
    storage.addToWishlist(5);
    storage.addToWishlist(10);

    // Kiểm tra có trong wishlist không
    bool isInWishlist = storage.isInWishlist(1);
    print('Product 1 in wishlist: $isInWishlist');

    // Lấy tất cả wishlist
    List<int> wishlist = storage.getWishlist();
    print('Wishlist items: $wishlist');

    // Xóa khỏi wishlist
    storage.removeFromWishlist(5);
  }

  // ============ Ví dụ 8: Quản lý đơn hàng ============
  void example8_Orders() {
    // Thêm đơn hàng mới
    storage.addOrder({
      'id': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'date': DateTime.now().toIso8601String(),
      'status': 'processing',
      'total': 249.98,
      'items': [
        {'productId': 1, 'quantity': 2},
      ],
    });

    // Lấy tất cả đơn hàng
    List<Map<String, dynamic>> orders = storage.getOrders();
    print('Total orders: ${orders.length}');

    // Lọc đơn hàng theo status
    List<Map<String, dynamic>> processingOrders = orders
        .where((order) => order['status'] == 'processing')
        .toList();
    print('Processing orders: ${processingOrders.length}');
  }

  // ============ Ví dụ 9: Logout và xóa dữ liệu ============
  void example9_Logout() {
    // Xóa dữ liệu khi logout
    storage.clearAll();
    print('All data cleared');
  }

  // ============ Ví dụ 10: Generic read/write ============
  void example10_Generic() {
    // Lưu bất kỳ dữ liệu nào
    storage.write('customKey', 'customValue');
    storage.write('number', 123);
    storage.write('list', [1, 2, 3]);
    storage.write('map', {'key': 'value'});

    // Đọc dữ liệu
    String? value = storage.read<String>('customKey');
    int? number = storage.read<int>('number');
    List? list = storage.read<List>('list');
    Map? map = storage.read<Map>('map');

    print('Value: $value');
    print('Number: $number');
    print('List: $list');
    print('Map: $map');

    // Xóa key cụ thể
    storage.remove('customKey');
  }
}

