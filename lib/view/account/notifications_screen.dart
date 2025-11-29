import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _orderNotifications = true;
  bool _promotionNotifications = true;
  bool _paymentNotifications = true;
  bool _deliveryNotifications = true;
  bool _emailNotifications = false;
  bool _pushNotifications = true;
  bool _smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: AppTextStyles.h2),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSection(
              'Order Notifications',
              [
                _buildSwitchTile(
                  'Order Updates',
                  'Get notified about your order status',
                  _orderNotifications,
                  (value) => setState(() => _orderNotifications = value),
                ),
                _buildSwitchTile(
                  'Delivery Updates',
                  'Get notified when your order is delivered',
                  _deliveryNotifications,
                  (value) => setState(() => _deliveryNotifications = value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Marketing',
              [
                _buildSwitchTile(
                  'Promotions & Offers',
                  'Receive notifications about special offers',
                  _promotionNotifications,
                  (value) => setState(() => _promotionNotifications = value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Payment',
              [
                _buildSwitchTile(
                  'Payment Notifications',
                  'Get notified about payment transactions',
                  _paymentNotifications,
                  (value) => setState(() => _paymentNotifications = value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Notification Methods',
              [
                _buildSwitchTile(
                  'Push Notifications',
                  'Receive push notifications on your device',
                  _pushNotifications,
                  (value) => setState(() => _pushNotifications = value),
                ),
                _buildSwitchTile(
                  'Email Notifications',
                  'Receive notifications via email',
                  _emailNotifications,
                  (value) => setState(() => _emailNotifications = value),
                ),
                _buildSwitchTile(
                  'SMS Notifications',
                  'Receive notifications via SMS',
                  _smsNotifications,
                  (value) => setState(() => _smsNotifications = value),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notification settings saved'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Settings',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonLarge,
                      Colors.white,
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

  Widget _buildSection(String title, List<Widget> children) {
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

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      title: Text(title, style: AppTextStyles.bodyMedium),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.withColor(
          AppTextStyles.bodySmall,
          Colors.grey,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

