import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';
import 'package:flutter_ecom_app/view/widgets/product_grid.dart';
import 'package:flutter_ecom_app/view/search_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  String _selectedCategory = 'All';
  double _minPrice = 0;
  double _maxPrice = 500;
  String _sortBy = 'Popular';

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filters', style: AppTextStyles.h2),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            _selectedCategory = 'All';
                            _minPrice = 0;
                            _maxPrice = 500;
                            _sortBy = 'Popular';
                          });
                          setState(() {});
                        },
                        child: Text(
                          'Reset',
                          style: AppTextStyles.withColor(
                            AppTextStyles.bodyMedium,
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Section
                        Text('Category', style: AppTextStyles.h3),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              [
                                'All',
                                'Footwear',
                                'Electronics',
                                'Clothing',
                              ].map((category) {
                                final isSelected =
                                    _selectedCategory == category;
                                return FilterChip(
                                  label: Text(category),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setModalState(() {
                                      _selectedCategory = category;
                                    });
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.transparent,
                                  selectedColor: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.2),
                                  labelStyle: AppTextStyles.withColor(
                                    AppTextStyles.bodyMedium,
                                    isSelected
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.color!,
                                  ),
                                  side: BorderSide(
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 24),
                        // Price Range Section
                        Text('Price Range', style: AppTextStyles.h3),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${_minPrice.toInt()}',
                              style: AppTextStyles.bodyMedium,
                            ),
                            Text(
                              '\$${_maxPrice.toInt()}',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                        RangeSlider(
                          values: RangeValues(_minPrice, _maxPrice),
                          min: 0,
                          max: 500,
                          divisions: 50,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (values) {
                            setModalState(() {
                              _minPrice = values.start;
                              _maxPrice = values.end;
                            });
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 24),
                        // Sort By Section
                        Text('Sort By', style: AppTextStyles.h3),
                        const SizedBox(height: 12),
                        ...[
                          'Popular',
                          'Newest',
                          'Price: Low to High',
                          'Price: High to Low',
                        ].map((sort) {
                          return RadioListTile<String>(
                            title: Text(sort, style: AppTextStyles.bodyMedium),
                            value: sort,
                            groupValue: _sortBy,
                            activeColor: Theme.of(context).primaryColor,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setModalState(() {
                                _sortBy = value!;
                              });
                              setState(() {});
                            },
                          );
                        }),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // Apply Button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Apply Filters',
                        style: AppTextStyles.withColor(
                          AppTextStyles.buttonLarge,
                          Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products', style: AppTextStyles.h2),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
