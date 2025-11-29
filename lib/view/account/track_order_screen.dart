import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final _orderIdController = TextEditingController();

  @override
  void dispose() {
    _orderIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order', style: AppTextStyles.h2),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Enter Order ID', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            TextField(
              controller: _orderIdController,
              enableInteractiveSelection: true,
              readOnly: false,
              decoration: InputDecoration(
                hintText: 'e.g., ORD-123456',
                prefixIcon: const Icon(Icons.receipt_long_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_orderIdController.text.isNotEmpty) {
                    _showTrackingDetails(context, _orderIdController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter an order ID')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Track Order',
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonLarge,
                    Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text('Recent Orders', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            _buildRecentOrderCard('ORD-123456', 'Processing', 0),
            const SizedBox(height: 12),
            _buildRecentOrderCard('ORD-123455', 'Shipped', 1),
            const SizedBox(height: 12),
            _buildRecentOrderCard('ORD-123454', 'Delivered', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrderCard(String orderId, String status, int statusIndex) {
    final statusColors = [Colors.orange, Colors.blue, Colors.green];

    return InkWell(
      onTap: () => _showTrackingDetails(context, orderId),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID: $orderId', style: AppTextStyles.bodyMedium),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColors[statusIndex].withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: AppTextStyles.withColor(
                          AppTextStyles.labelMedium,
                          statusColors[statusIndex],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  void _showTrackingDetails(BuildContext context, String orderId) {
    final trackingSteps = [
      {'title': 'Order Placed', 'date': 'Jan 15, 2024', 'completed': true},
      {'title': 'Order Confirmed', 'date': 'Jan 15, 2024', 'completed': true},
      {'title': 'Processing', 'date': 'Jan 16, 2024', 'completed': true},
      {'title': 'Shipped', 'date': 'Jan 17, 2024', 'completed': false},
      {'title': 'Out for Delivery', 'date': 'Jan 18, 2024', 'completed': false},
      {'title': 'Delivered', 'date': 'Jan 19, 2024', 'completed': false},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Tracking', style: AppTextStyles.h2),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Order ID: $orderId',
              style: AppTextStyles.withColor(
                AppTextStyles.bodyMedium,
                Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ...trackingSteps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isLast = index == trackingSteps.length - 1;

              return _buildTrackingStep(
                step['title'] as String,
                step['date'] as String,
                step['completed'] as bool,
                isLast,
              );
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Close',
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonLarge,
                    Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep(
    String title,
    String date,
    bool completed,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withValues(alpha: 0.3),
              ),
              child: completed
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: completed
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodyMedium,
                    completed ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodySmall,
                    Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
