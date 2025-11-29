import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/wishlist_controller.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';
import 'package:flutter_ecom_app/view/product_detail_screen.dart';
import 'package:flutter_ecom_app/view/widgets/product_card.dart';
import 'package:get/get.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find<WishlistController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist', style: AppTextStyles.h2),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Obx(
        () {
          final wishlistProducts = wishlistController.wishlistProducts;

          return wishlistProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 100,
                        color: Colors.grey.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text('Your wishlist is empty', style: AppTextStyles.h3),
                      const SizedBox(height: 8),
                      Text(
                        'Add items you love to your wishlist',
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodyMedium,
                          Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: wishlistProducts.length,
                  itemBuilder: (context, index) {
                    final product = wishlistProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: ProductCard(product: product),
                    );
                  },
                );
        },
      ),
    );
  }
}
