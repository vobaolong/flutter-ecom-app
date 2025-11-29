import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/navigation_controler.dart';
import 'package:flutter_ecom_app/view/account_screen.dart';
import 'package:flutter_ecom_app/view/home_screen.dart';
import 'package:flutter_ecom_app/view/shopping_screen.dart';
import 'package:flutter_ecom_app/view/widgets/custom_bottom_navbar.dart';
import 'package:flutter_ecom_app/view/wishlist_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // Cache screens để tránh rebuild không cần thiết
  static final List<Widget> _screens = const [
    HomeScreen(),
    ShoppingScreen(),
    WishListScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(
        () => IndexedStack(
          index: navigationController.currentIndex.value,
          children: _screens,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
