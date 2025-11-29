import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';
import 'package:flutter_ecom_app/view/signin_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_ecom_app/view/account/addresses_screen.dart';
import 'package:flutter_ecom_app/view/account/edit_profile_screen.dart';
import 'package:flutter_ecom_app/view/account/generic_info_screen.dart';
import 'package:flutter_ecom_app/view/account/my_orders_screen.dart';
import 'package:flutter_ecom_app/view/account/notifications_screen.dart';
import 'package:flutter_ecom_app/view/account/payment_methods_screen.dart';
import 'package:flutter_ecom_app/view/account/track_order_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = _authController.user;
    final userName = user?['name'] ?? 'Guest';
    final userEmail = user?['email'] ?? 'No email';
    final userAvatar = user?['avatar'] ?? 'assets/images/avatar.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: AppTextStyles.h2),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Section
            CircleAvatar(radius: 50, backgroundImage: AssetImage(userAvatar)),
            const SizedBox(height: 16),
            Text(userName, style: AppTextStyles.h2),
            const SizedBox(height: 4),
            Text(
              userEmail,
              style: AppTextStyles.withColor(
                AppTextStyles.bodyMedium,
                Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            // Account Options
            _buildSection(context, 'Account Settings', [
              _buildListTile(context, Icons.person_outline, 'Edit Profile', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              }),
              _buildListTile(
                context,
                Icons.location_on_outlined,
                'Addresses',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddressesScreen(),
                    ),
                  );
                },
              ),
              _buildListTile(
                context,
                Icons.payment_outlined,
                'Payment Methods',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentMethodsScreen(),
                    ),
                  );
                },
              ),
              _buildListTile(
                context,
                Icons.notifications_outlined,
                'Notifications',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
            ]),
            const SizedBox(height: 16),
            _buildSection(context, 'Orders', [
              _buildListTile(
                context,
                Icons.shopping_bag_outlined,
                'My Orders',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyOrdersScreen(),
                    ),
                  );
                },
              ),
              _buildListTile(
                context,
                Icons.local_shipping_outlined,
                'Track Order',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackOrderScreen(),
                    ),
                  );
                },
              ),
            ]),
            const SizedBox(height: 16),
            _buildSection(context, 'Support', [
              _buildListTile(context, Icons.help_outline, 'Help Center', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenericInfoScreen(
                      title: 'Help Center',
                      content:
                          'Welcome to our Help Center!\n\n'
                          'Here you can find answers to frequently asked questions and get support for your account.\n\n'
                          'If you need further assistance, please contact our support team at support@example.com or call us at +1 234 567 8900.\n\n'
                          'Our support hours are Monday to Friday, 9 AM to 6 PM EST.',
                    ),
                  ),
                );
              }),
              _buildListTile(context, Icons.info_outline, 'About', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenericInfoScreen(
                      title: 'About',
                      content:
                          'Flutter E-Commerce App\n\n'
                          'Version 1.0.0\n\n'
                          'This is a modern e-commerce application built with Flutter. '
                          'We provide a seamless shopping experience with a wide range of products, '
                          'secure payment options, and fast delivery.\n\n'
                          '© 2024 Flutter E-Commerce App. All rights reserved.',
                    ),
                  ),
                );
              }),
              _buildListTile(context, Icons.privacy_tip_outlined, 'Privacy Policy', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenericInfoScreen(
                      title: 'Privacy Policy',
                      content:
                          'Privacy Policy\n\n'
                          'Last Updated: January 2024\n\n'
                          '1. Information We Collect\n'
                          'We collect information that you provide directly to us, including your name, email address, '
                          'phone number, shipping address, and payment information.\n\n'
                          '2. How We Use Your Information\n'
                          'We use the information we collect to process your orders, communicate with you, '
                          'and improve our services.\n\n'
                          '3. Information Sharing\n'
                          'We do not sell, trade, or rent your personal information to third parties.\n\n'
                          '4. Data Security\n'
                          'We implement appropriate security measures to protect your personal information.\n\n'
                          '5. Your Rights\n'
                          'You have the right to access, update, or delete your personal information at any time.',
                    ),
                  ),
                );
              }),
            ]),
            const SizedBox(height: 24),
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.red.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonLarge,
                      Colors.red.shade400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: AppTextStyles.h3),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: AppTextStyles.h3),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.withColor(
                AppTextStyles.buttonMedium,
                Colors.grey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _authController.logout();
              Navigator.pop(context);
              Get.offAll(() => SigninScreen());
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'Logout',
              style: AppTextStyles.withColor(
                AppTextStyles.buttonMedium,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
