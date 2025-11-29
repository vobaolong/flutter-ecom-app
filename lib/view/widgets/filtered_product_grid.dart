import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/models/products.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';
import 'package:flutter_ecom_app/view/product_detail_screen.dart';
import 'package:flutter_ecom_app/view/widgets/product_card.dart';

class FilteredProductGrid extends StatelessWidget {
  final String? selectedCategory;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;

  const FilteredProductGrid({
    super.key,
    this.selectedCategory,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
  });

  List<Product> _getFilteredProducts() {
    List<Product> filtered = List.from(products);

    // Filter by category
    if (selectedCategory != null && selectedCategory != 'All') {
      filtered = filtered.where((p) => p.category == selectedCategory).toList();
    }

    // Filter by price range
    if (minPrice != null && maxPrice != null) {
      filtered = filtered
          .where((p) => p.price >= minPrice! && p.price <= maxPrice!)
          .toList();
    }

    // Sort products
    if (sortBy != null) {
      switch (sortBy) {
        case 'Newest':
          // Giả sử sản phẩm mới hơn có ID lớn hơn
          filtered.sort((a, b) => b.id.compareTo(a.id));
          break;
        case 'Price: Low to High':
          filtered.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Price: High to Low':
          filtered.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'Popular':
        default:
          // Giữ nguyên thứ tự (popular)
          break;
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();

    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text('No products found', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: AppTextStyles.withColor(
                AppTextStyles.bodyMedium,
                Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: ProductCard(product: product),
        );
      },
    );
  }
}
