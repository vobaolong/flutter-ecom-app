/// Ví dụ cách lưu trữ dữ liệu khi Login
/// File này chỉ để tham khảo

import 'package:flutter_ecom_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthExample {
  final AuthController authController = Get.find<AuthController>();

  // ============ Ví dụ 1: Login với API thật ============
  Future<void> example1_LoginWithAPI() async {
    // Giả sử bạn có API service
    // final apiService = ApiService();

    try {
      // 1. Gọi API login
      // final response = await apiService.login(
      //   email: 'user@example.com',
      //   password: 'password123',
      // );

      // 2. Lưu dữ liệu vào storage
      // authController.login(
      //   token: response.data['access_token'],
      //   userData: {
      //     'id': response.data['user']['id'],
      //     'name': response.data['user']['name'],
      //     'email': response.data['user']['email'],
      //     'avatar': response.data['user']['avatar'],
      //   },
      //   refreshToken: response.data['refresh_token'],
      // );

      // 3. Navigate to main screen
      // Get.offAll(() => MainScreen());

      print('Login successful!');
    } catch (e) {
      print('Login failed: $e');
      // Show error message
    }
  }

  // ============ Ví dụ 2: Kiểm tra đăng nhập khi mở app ============
  Future<void> example2_CheckLoginOnAppStart() async {
    // Trong SplashScreen hoặc main.dart

    if (authController.isLoggedIn) {
      // Kiểm tra token còn hợp lệ không
      if (authController.isTokenValid()) {
        // Token còn hợp lệ → vào MainScreen
        // Get.offAll(() => MainScreen());
        print('User is logged in, token is valid');
      } else {
        // Token hết hạn → thử refresh hoặc logout
        // await _tryRefreshToken();
        // Hoặc logout và về SignInScreen
        authController.logout();
        // Get.offAll(() => SignInScreen());
        print('Token expired, user logged out');
      }
    } else {
      // Chưa đăng nhập → về SignInScreen
      // Get.offAll(() => SignInScreen());
      print('User is not logged in');
    }
  }

  // ============ Ví dụ 3: Refresh Token ============
  Future<void> example3_RefreshToken() async {
    // final refreshToken = authController.refreshToken;
    // if (refreshToken == null) {
    //   authController.logout();
    //   return;
    // }

    // try {
    //   final response = await apiService.refreshToken(refreshToken);
    //   authController.login(
    //     token: response.data['access_token'],
    //     userData: authController.user!,
    //     refreshToken: response.data['refresh_token'],
    //   );
    // } catch (e) {
    //   authController.logout();
    // }
  }

  // ============ Ví dụ 4: Logout ============
  void example4_Logout() {
    // Xóa tất cả dữ liệu đã lưu
    authController.logout();

    // Navigate về SignInScreen
    // Get.offAll(() => SignInScreen());

    print('User logged out');
  }

  // ============ Ví dụ 5: Lấy thông tin user đã lưu ============
  void example5_GetUserInfo() {
    final user = authController.user;
    final token = authController.token;
    final userId = authController.userId;

    if (user != null) {
      print('User ID: ${user['id']}');
      print('User Name: ${user['name']}');
      print('User Email: ${user['email']}');
      print('Token: $token');
      print('User ID from getter: $userId');
    } else {
      print('No user data found');
    }
  }

  // ============ Ví dụ 6: Cập nhật thông tin user ============
  void example6_UpdateUserInfo() {
    // Sau khi cập nhật profile thành công
    authController.updateUser({
      'id': authController.user?['id'],
      'name': 'John Updated',
      'email': 'john.updated@example.com',
      'avatar': 'assets/images/new_avatar.jpg',
    });

    print('User info updated');
  }

  // ============ Ví dụ 7: Sử dụng token trong API calls ============
  Future<void> example7_UseTokenInAPI() async {
    final token = authController.token;

    if (token == null) {
      print('No token available');
      return;
    }

    // Gọi API với token
    // final response = await http.get(
    //   Uri.parse('https://api.example.com/user/profile'),
    //   headers: {
    //     'Authorization': 'Bearer $token',
    //     'Content-Type': 'application/json',
    //   },
    // );

    print('API called with token: $token');
  }
}

/// Ví dụ Response từ API (cấu trúc thường gặp)
class LoginResponse {
  final String accessToken;
  final String? refreshToken;
  final Map<String, dynamic> user;
  final DateTime? expiresAt;

  LoginResponse({
    required this.accessToken,
    this.refreshToken,
    required this.user,
    this.expiresAt,
  });

  // Parse từ JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? json['token'],
      refreshToken: json['refresh_token'],
      user: json['user'] ?? json['data'],
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
    );
  }
}
