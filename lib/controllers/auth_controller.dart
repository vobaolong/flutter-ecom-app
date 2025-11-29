import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();

  final RxBool _isFirstTime = false.obs;
  final RxBool _isLoggedIn = false.obs;

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;

  // User information
  Map<String, dynamic>? get user => _storage.read('user');
  String? get token => _storage.read('token');
  String? get userId => user?['id']?.toString();

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
  }

  void _loadInitialState() {
    _isFirstTime.value = _storage.read('isFirstTime') ?? false;
    _isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
  }

  void setFirstTime() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  /// Login và lưu thông tin user
  ///
  /// [token]: Access token từ API
  /// [userData]: Thông tin user (id, name, email, etc.)
  /// [refreshToken]: Refresh token (optional)
  void login({
    required String token,
    required Map<String, dynamic> userData,
    String? refreshToken,
  }) {
    // Lưu token
    _storage.write('token', token);

    // Lưu refresh token nếu có
    if (refreshToken != null) {
      _storage.write('refreshToken', refreshToken);
    }

    // Lưu thông tin user
    _storage.write('user', userData);

    // Lưu thời gian login
    _storage.write('loginTime', DateTime.now().toIso8601String());

    _isLoggedIn.value = true;
    _storage.write('isLoggedIn', true);

    update();
  }

  /// Login đơn giản (cho demo, không có API)
  void loginSimple() {
    _isLoggedIn.value = true;
    _storage.write('isLoggedIn', true);

    _storage.write('user', {
      'id': 1,
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'avatar': 'assets/images/avatar.jpg',
    });

    update();
  }

  void logout() {
    _storage.remove('token');
    _storage.remove('refreshToken');

    _storage.remove('user');
    _storage.remove('loginTime');

    _isLoggedIn.value = false;
    _storage.write('isLoggedIn', false);

    update();
  }

  bool isTokenValid() {
    final token = _storage.read('token');
    if (token == null) return false;

    final loginTime = _storage.read<String>('loginTime');
    if (loginTime != null) {
      final loginDateTime = DateTime.parse(loginTime);
      final now = DateTime.now();
      final difference = now.difference(loginDateTime);

      if (difference.inDays > 7) {
        return false;
      }
    }

    return true;
  }

  void updateUser(Map<String, dynamic> userData) {
    _storage.write('user', userData);
    update();
  }
}
