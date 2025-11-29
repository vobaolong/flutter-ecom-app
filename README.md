# 🛍️ Flutter E-Commerce App

Ứng dụng mua sắm điện tử được xây dựng bằng Flutter - Dự án Flutter đầu tiên của tôi!

## 📱 Giới thiệu

Đây là một ứng dụng e-commerce hoàn chỉnh với đầy đủ các tính năng cơ bản như xem sản phẩm, thêm vào giỏ hàng, wishlist, quản lý tài khoản và nhiều hơn nữa. Dự án được xây dựng với Flutter framework và sử dụng GetX cho state management.

## ✨ Tính năng

### 🏠 Trang chủ

- Hiển thị sản phẩm mới nhất
- Banner khuyến mãi
- Danh mục sản phẩm
- Tìm kiếm sản phẩm

### 🛒 Mua sắm

- Xem tất cả sản phẩm
- Lọc sản phẩm theo danh mục
- Lọc theo khoảng giá
- Sắp xếp sản phẩm (Phổ biến, Mới nhất, Giá tăng/giảm)
- Tìm kiếm sản phẩm

### ❤️ Wishlist

- Thêm/xóa sản phẩm vào wishlist
- Xem danh sách sản phẩm yêu thích
- Dữ liệu được lưu local (persist giữa các lần mở app)

### 👤 Tài khoản

- Đăng nhập / Đăng ký
- Chỉnh sửa thông tin cá nhân
- Quản lý địa chỉ giao hàng
- Quản lý phương thức thanh toán
- Cài đặt thông báo
- Xem đơn hàng
- Theo dõi đơn hàng

### 🎨 Giao diện

- Dark mode / Light mode
- UI/UX hiện đại, đẹp mắt
- Responsive design
- Smooth animations

## 🚀 Cài đặt và Chạy

### Yêu cầu

- Flutter SDK (>=3.10.0)
- Dart SDK
- Android Studio / VS Code với Flutter extension
- iOS Simulator / Android Emulator hoặc thiết bị thật

### Các bước cài đặt

1. **Clone repository**

```bash
git clone <repository-url>
cd flutter_ecom_app
```

2. **Cài đặt dependencies**

```bash
flutter pub get
```

3. **Chạy ứng dụng**

```bash
# Chạy trên iOS Simulator
flutter run -d ios

# Chạy trên Android Emulator
flutter run -d android

# Hoặc chọn device khi chạy
flutter run
```

## 📁 Cấu trúc Project

```
lib/
├── controllers/          # State management với GetX
│   ├── auth_controller.dart
│   ├── navigation_controler.dart
│   ├── theme_controller.dart
│   └── wishlist_controller.dart
│
├── models/               # Data models
│   └── products.dart
│
├── services/             # Services và utilities
│   ├── storage_service.dart
│   ├── auth_example.dart
│   └── storage_example.dart
│
├── utils/                # Utilities
│   ├── app_textstyles.dart
│   └── app_theme.dart
│
└── view/                 # UI Screens và Widgets
    ├── account/          # Account related screens
    ├── widgets/          # Reusable widgets
    ├── home_screen.dart
    ├── shopping_screen.dart
    ├── wishlist_screen.dart
    ├── cart_screen.dart
    └── ...
```

## 🛠️ Công nghệ sử dụng

### Core

- **Flutter** - UI Framework
- **Dart** - Programming Language

### State Management

- **GetX** - State management, dependency injection, routing

### Storage

- **GetStorage** - Local storage (tương tự localStorage trong web)

### UI/UX

- **Google Fonts** - Custom fonts
- **Material Design** - Design system

### Packages chính

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.7.2 # State management
  get_storage: ^2.1.1 # Local storage
  google_fonts: ^6.3.2 # Custom fonts
  share_plus: ^12.0.1 # Share functionality
```

## 📱 Screenshots

_(Thêm screenshots của app vào đây nếu có)_

## 🎯 Các tính năng chính

### 1. Authentication

- Đăng nhập / Đăng ký
- Lưu trữ session (token, user info)
- Auto-login khi mở app lại

### 2. Product Management

- Xem danh sách sản phẩm
- Xem chi tiết sản phẩm
- Tìm kiếm sản phẩm
- Lọc và sắp xếp sản phẩm

### 3. Wishlist

- Thêm/xóa sản phẩm vào wishlist
- Dữ liệu được lưu local
- Đồng bộ giữa các màn hình

### 4. Shopping Cart

- Thêm sản phẩm vào giỏ hàng
- Quản lý số lượng
- Tính tổng tiền

### 5. User Profile

- Chỉnh sửa thông tin cá nhân
- Quản lý địa chỉ
- Quản lý phương thức thanh toán
- Cài đặt thông báo

## 💾 Lưu trữ dữ liệu

App sử dụng **GetStorage** để lưu trữ dữ liệu local:

- Thông tin đăng nhập (token, user info)
- Wishlist
- Giỏ hàng
- Địa chỉ
- Phương thức thanh toán
- Cài đặt thông báo
- Theme preference (dark/light mode)

Dữ liệu được lưu tự động và persist giữa các lần mở app.

## 🎨 Theme

App hỗ trợ 2 chế độ:

- **Light Mode** - Giao diện sáng
- **Dark Mode** - Giao diện tối

Người dùng có thể chuyển đổi theme từ menu trên trang chủ. Preference được lưu tự động.

## 🔧 Development

### Chạy trên iOS Simulator

```bash
# Mở iOS Simulator trước
open -a Simulator

# Chạy app
flutter run
```

### Chạy trên Android Emulator

```bash
# Mở Android Emulator từ Android Studio
# Sau đó chạy
flutter run
```

### Build APK

```bash
flutter build apk --release
```

### Build iOS

```bash
flutter build ios --release
```

## 📚 Học được gì từ dự án này

Đây là dự án Flutter đầu tiên, tôi đã học được:

1. **Flutter Basics**

   - Widget tree và state management
   - Navigation và routing
   - Custom widgets

2. **GetX State Management**

   - Controllers và reactive programming
   - Dependency injection
   - GetX navigation

3. **Local Storage**

   - GetStorage để lưu dữ liệu local
   - Persist data giữa các sessions

4. **UI/UX Design**

   - Material Design
   - Dark mode implementation
   - Responsive layouts

5. **Best Practices**
   - Code organization
   - Separation of concerns
   - Reusable components

## 🐛 Known Issues

- [ ] Chưa tích hợp API thật (đang dùng mock data)
- [ ] Chưa có payment gateway
- [ ] Chưa có push notifications

## 🚧 TODO

- [ ] Tích hợp API backend
- [ ] Thêm tính năng thanh toán
- [ ] Thêm push notifications
- [ ] Thêm tính năng đánh giá sản phẩm
- [ ] Thêm tính năng so sánh sản phẩm
- [ ] Cải thiện performance
- [ ] Thêm unit tests

## 📝 Notes

- Đây là dự án học tập, một số tính năng có thể chưa hoàn chỉnh
- Dữ liệu sản phẩm hiện tại là mock data
- Authentication hiện tại là demo (chưa có API thật)

## 🤝 Contributing

Đây là dự án cá nhân, nhưng mọi góp ý và đóng góp đều được chào đón!

## 📄 License

Dự án này được tạo cho mục đích học tập.

## 👨‍💻 Author

---

**Happy Coding! 🚀**
