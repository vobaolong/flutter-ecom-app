import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 1,
      'type': 'card',
      'cardNumber': '**** **** **** 4242',
      'cardHolder': 'John Doe',
      'expiryDate': '12/25',
      'isDefault': true,
      'icon': Icons.credit_card,
    },
    {
      'id': 2,
      'type': 'card',
      'cardNumber': '**** **** **** 8888',
      'cardHolder': 'John Doe',
      'expiryDate': '06/26',
      'isDefault': false,
      'icon': Icons.credit_card,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods', style: AppTextStyles.h2),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: _paymentMethods.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _paymentMethods.length + 1,
              itemBuilder: (context, index) {
                if (index == _paymentMethods.length) {
                  return const SizedBox(height: 80);
                }
                return _buildPaymentCard(_paymentMethods[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPaymentDialog(context),
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Payment Method',
          style: AppTextStyles.withColor(
            AppTextStyles.buttonMedium,
            Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payment_outlined,
            size: 80,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No payment methods',
            style: AppTextStyles.withColor(AppTextStyles.h3, Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a payment method to get started',
            style: AppTextStyles.withColor(
              AppTextStyles.bodyMedium,
              Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: payment['isDefault']
            ? Border.all(color: Theme.of(context).primaryColor, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    payment['icon'],
                    color: Theme.of(context).primaryColor,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(payment['cardNumber'], style: AppTextStyles.h3),
                      const SizedBox(height: 4),
                      Text(
                        '${payment['cardHolder']} • ${payment['expiryDate']}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              if (payment['isDefault'])
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Default',
                    style: AppTextStyles.withColor(
                      AppTextStyles.labelMedium,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!payment['isDefault'])
                TextButton(
                  onPressed: () => _setAsDefault(payment['id']),
                  child: Text(
                    'Set as Default',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonSmall,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              TextButton(
                onPressed: () => _showDeleteDialog(payment),
                child: Text(
                  'Delete',
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonSmall,
                    Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddPaymentDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _cardNumberController = TextEditingController();
    final _cardHolderController = TextEditingController();
    final _expiryDateController = TextEditingController();
    final _cvvController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Payment Method', style: AppTextStyles.h3),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogTextField(
                  'Card Number',
                  _cardNumberController,
                  hint: '1234 5678 9012 3456',
                ),
                const SizedBox(height: 12),
                _buildDialogTextField(
                  'Card Holder Name',
                  _cardHolderController,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDialogTextField(
                        'Expiry Date',
                        _expiryDateController,
                        hint: 'MM/YY',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDialogTextField(
                        'CVV',
                        _cvvController,
                        hint: '123',
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
              if (_formKey.currentState!.validate()) {
                setState(() {
                  final cardNumber = _cardNumberController.text;
                  final lastFour = cardNumber.length >= 4
                      ? cardNumber.substring(cardNumber.length - 4)
                      : '****';
                  _paymentMethods.add({
                    'id': _paymentMethods.length + 1,
                    'type': 'card',
                    'cardNumber': '**** **** **** $lastFour',
                    'cardHolder': _cardHolderController.text,
                    'expiryDate': _expiryDateController.text,
                    'isDefault': _paymentMethods.isEmpty,
                    'icon': Icons.credit_card,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment method added successfully'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Add',
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

  Widget _buildDialogTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enableInteractiveSelection: true,
      readOnly: false,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  void _setAsDefault(int id) {
    setState(() {
      for (var payment in _paymentMethods) {
        payment['isDefault'] = payment['id'] == id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Default payment method updated')),
    );
  }

  void _showDeleteDialog(Map<String, dynamic> payment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Payment Method', style: AppTextStyles.h3),
        content: Text(
          'Are you sure you want to delete this payment method?',
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
              setState(() {
                _paymentMethods.removeWhere((p) => p['id'] == payment['id']);
                if (_paymentMethods.isNotEmpty && payment['isDefault']) {
                  _paymentMethods[0]['isDefault'] = true;
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment method deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'Delete',
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
