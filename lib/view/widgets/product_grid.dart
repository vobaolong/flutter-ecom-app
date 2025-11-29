import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/models/products.dart';
import 'package:flutter_ecom_app/view/product_detail_screen.dart';
import 'package:flutter_ecom_app/view/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product>? productList;
  final int? itemCount;
  final bool isScrollable;

  const ProductGrid({
    super.key,
    this.productList,
    this.itemCount,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final displayProducts = productList ?? products;
    final count = itemCount ?? displayProducts.length;
    final productsToShow = displayProducts.take(count).toList();

    if (productsToShow.isEmpty) {
      return const Center(child: Text('No products available'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: !isScrollable,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: productsToShow.length,
      itemBuilder: (context, index) {
        final product = productsToShow[index];
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
