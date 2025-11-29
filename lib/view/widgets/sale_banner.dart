import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';

class SaleBanner extends StatelessWidget {
  const SaleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get your',
                  style: AppTextStyles.withColor(
                    AppTextStyles.withFontWeight(
                      AppTextStyles.h3,
                      FontWeight.bold,
                    ),
                    Colors.white,
                  ),
                ),
                Text(
                  'Special Sale',
                  style: AppTextStyles.withColor(
                    AppTextStyles.withFontWeight(
                      AppTextStyles.h2,
                      FontWeight.bold,
                    ),
                    Colors.white,
                  ),
                ),
                Text(
                  'Up to 20% off',
                  style: AppTextStyles.withColor(
                    AppTextStyles.withFontWeight(
                      AppTextStyles.h3,
                      FontWeight.bold,
                    ),
                    Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: Text('Shop Now', style: AppTextStyles.buttonMedium),
          ),
        ],
      ),
    );
  }
}
