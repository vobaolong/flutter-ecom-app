import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/navigation_controler.dart';
import 'package:flutter_ecom_app/controllers/theme_controller.dart';
import 'package:flutter_ecom_app/view/account_screen.dart';
import 'package:flutter_ecom_app/view/home_screen.dart';
import 'package:flutter_ecom_app/view/shopping_screen.dart';
import 'package:flutter_ecom_app/view/widgets/custom_bottom_navbar.dart';
import 'package:flutter_ecom_app/view/wishlist_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return GetBuilder<ThemeController>(
      builder: (themeController) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Obx(
            () => IndexedStack(
              key: ValueKey(navigationController.currentIndex),
              children: [
                HomeScreen(),
                ShoppingScreen(),
                WishListScreen(),
                AccountScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }
}
