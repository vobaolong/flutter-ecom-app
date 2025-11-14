import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';
import 'package:flutter_ecom_app/view/main_screen.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Discover Later Trends',
      description:
          'Explore the latest fashion trends and find your unique style',
      image: 'assets/images/intro.png',
    ),
    OnboardingItem(
      title: 'Quality Products',
      description: 'Shop premium quality products from top brands worldwide',
      image: 'assets/images/intro1.png',
    ),
    OnboardingItem(
      title: 'Easy Shopping',
      description: 'Simple and secure shopping experience with fast delivery',
      image: 'assets/images/intro2.png',
    ),
  ];

  void _handleGetStarted() {
    final AuthController authController = Get.find<AuthController>();
    authController.setFirstTime();
    Get.off(() => MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _items[index].image,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _items[index].title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.withColor(
                      AppTextStyles.h1,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _items[index].description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyLarge,
                        isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == _currentPage
                        ? Theme.of(context).primaryColor
                        : (isDarkMode ? Colors.grey[400]! : Colors.grey[600]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _handleGetStarted(),
                  child: Text(
                    'Skip',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium,
                      isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _items.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _handleGetStarted();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage < _items.length - 1 ? 'Next' : 'Get Started',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingItem({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
