import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        enableInteractiveSelection: true,
        readOnly: false,
        style: AppTextStyles.withColor(
          AppTextStyles.buttonMedium,
          Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          suffixIcon: Icon(
            Icons.tune,
            color: isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          hintText: 'Search',
          hintStyle: AppTextStyles.withColor(
            AppTextStyles.buttonMedium,
            isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
          ),
        ),
      ),
    );
  }
}
