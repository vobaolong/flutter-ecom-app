import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/wishlist_controller.dart';
import 'package:flutter_ecom_app/models/products.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColor = 0;
  int _selectedSize = 1;
  final WishlistController _wishlistController = Get.find<WishlistController>();

  final List<Color> _colors = [
    Colors.black,
    Colors.blueGrey,
    Colors.redAccent,
    Colors.teal,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.4,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: isDarkMode ? Colors.black54 : Colors.white70,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 20),
                  color: isDarkMode ? Colors.white : Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () {
                    final isFavorite = _wishlistController.isInWishlist(widget.product.id);
                    return CircleAvatar(
                      backgroundColor: isDarkMode ? Colors.black54 : Colors.white70,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                        ),
                        color: isFavorite
                            ? Colors.red
                            : (isDarkMode ? Colors.white : Colors.black),
                        onPressed: () {
                          _wishlistController.toggleWishlist(widget.product.id);
                          Get.snackbar(
                            isFavorite ? 'Removed from wishlist' : 'Added to wishlist',
                            widget.product.name,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 1),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(widget.product.image, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              transform: Matrix4.translationValues(0, -20, 0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: AppTextStyles.h2,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.product.category,
                                style: AppTextStyles.withColor(
                                  AppTextStyles.bodyMedium,
                                  Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: AppTextStyles.withColor(
                                AppTextStyles.h2,
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            if (widget.product.oldPrice != null)
                              Text(
                                '\$${widget.product.oldPrice!.toStringAsFixed(2)}',
                                style:
                                    AppTextStyles.withColor(
                                      AppTextStyles.bodySmall,
                                      Colors.grey,
                                    ).copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '4.8',
                          style: AppTextStyles.withFontWeight(
                            AppTextStyles.bodyMedium,
                            FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(120 reviews)',
                          style: AppTextStyles.withColor(
                            AppTextStyles.bodySmall,
                            Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Description', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    Text(
                      widget.product.description,
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyMedium,
                        isDarkMode ? Colors.grey[300]! : Colors.grey[700]!,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Color', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    Row(
                      children: _colors.asMap().entries.map((entry) {
                        final isSelected = _selectedColor == entry.key;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedColor = entry.key),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: entry.value,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text('Size', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    Row(
                      children: ['S', 'M', 'L', 'XL'].asMap().entries.map((
                        entry,
                      ) {
                        final isSelected = _selectedSize == entry.key;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedSize = entry.key),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.withValues(alpha: 0.4),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              entry.value,
                              style: AppTextStyles.withColor(
                                AppTextStyles.bodyMedium,
                                isSelected
                                    ? Colors.white
                                    : (isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 100), // Space for bottom bar
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonLarge,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Buy Now',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonLarge,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
