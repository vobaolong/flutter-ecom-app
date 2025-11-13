import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/theme_controller.dart';
import 'package:flutter_ecom_app/utils/app_theme.dart';
import 'package:flutter_ecom_app/view/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      title: 'E-commerce App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home: const SplashScreen(),
    );
  }
}
