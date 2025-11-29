import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/theme_controller.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';
import 'package:flutter_ecom_app/view/all_products_screen.dart';
import 'package:flutter_ecom_app/view/cart_screen.dart';
import 'package:flutter_ecom_app/view/search_screen.dart';
import 'package:flutter_ecom_app/view/widgets/category_chips.dart';
import 'package:flutter_ecom_app/view/widgets/custom_search_bar.dart';
import 'package:flutter_ecom_app/view/widgets/product_grid.dart';
import 'package:flutter_ecom_app/view/widgets/sale_banner.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, John Doe',
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodySmall,
                          Colors.grey,
                        ),
                      ),
                      Text(
                        'Welcome back!',
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodyMedium,
                          Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.shopping_cart_outlined),
                      ),
                      GetBuilder<ThemeController>(
                        builder: (controller) {
                          return IconButton(
                            onPressed: () => {controller.toggleTheme()},
                            icon: Icon(
                              controller.isDarkMode
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CustomSearchBar(),
            const CategoryChips(),
            const SaleBanner(),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('New Arrivals', style: AppTextStyles.h3),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllProductsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyMedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }
}
