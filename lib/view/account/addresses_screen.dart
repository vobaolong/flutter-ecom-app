import 'package:flutter/material.dart';
import 'package:flutter_ecom_app/utils/app_textstyles.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': 1,
      'name': 'John Doe',
      'phone': '+1 234 567 8900',
      'address': '123 Main Street',
      'city': 'New York',
      'state': 'NY',
      'zipCode': '10001',
      'isDefault': true,
    },
    {
      'id': 2,
      'name': 'John Doe',
      'phone': '+1 234 567 8900',
      'address': '456 Oak Avenue',
      'city': 'Los Angeles',
      'state': 'CA',
      'zipCode': '90001',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addresses', style: AppTextStyles.h2),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: _addresses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length + 1,
              itemBuilder: (context, index) {
                if (index == _addresses.length) {
                  return const SizedBox(height: 80);
                }
                return _buildAddressCard(_addresses[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditAddressDialog(context),
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Address',
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
            Icons.location_on_outlined,
            size: 80,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No addresses saved',
            style: AppTextStyles.withColor(AppTextStyles.h3, Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first address to get started',
            style: AppTextStyles.withColor(
              AppTextStyles.bodyMedium,
              Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: address['isDefault']
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
              if (address['isDefault'])
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
                )
              else
                const SizedBox(),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () =>
                        _showAddEditAddressDialog(context, address: address),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: () => _showDeleteDialog(address),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(address['name'], style: AppTextStyles.h3),
          const SizedBox(height: 4),
          Text(address['phone'], style: AppTextStyles.bodyMedium),
          const SizedBox(height: 8),
          Text(
            '${address['address']}, ${address['city']}, ${address['state']} ${address['zipCode']}',
            style: AppTextStyles.bodyMedium,
          ),
          if (!address['isDefault']) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _setAsDefault(address['id']),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Set as Default',
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonSmall,
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddEditAddressDialog(
    BuildContext context, {
    Map<String, dynamic>? address,
  }) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: address?['name'] ?? '');
    final _phoneController = TextEditingController(
      text: address?['phone'] ?? '',
    );
    final _addressController = TextEditingController(
      text: address?['address'] ?? '',
    );
    final _cityController = TextEditingController(text: address?['city'] ?? '');
    final _stateController = TextEditingController(
      text: address?['state'] ?? '',
    );
    final _zipCodeController = TextEditingController(
      text: address?['zipCode'] ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          address == null ? 'Add Address' : 'Edit Address',
          style: AppTextStyles.h3,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogTextField('Full Name', _nameController),
                const SizedBox(height: 12),
                _buildDialogTextField('Phone', _phoneController),
                const SizedBox(height: 12),
                _buildDialogTextField('Address', _addressController),
                const SizedBox(height: 12),
                _buildDialogTextField('City', _cityController),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildDialogTextField('State', _stateController),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: _buildDialogTextField(
                        'Zip Code',
                        _zipCodeController,
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
                if (address == null) {
                  setState(() {
                    _addresses.add({
                      'id': _addresses.length + 1,
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'address': _addressController.text,
                      'city': _cityController.text,
                      'state': _stateController.text,
                      'zipCode': _zipCodeController.text,
                      'isDefault': _addresses.isEmpty,
                    });
                  });
                } else {
                  setState(() {
                    final index = _addresses.indexWhere(
                      (a) => a['id'] == address['id'],
                    );
                    if (index != -1) {
                      _addresses[index] = {
                        ..._addresses[index],
                        'name': _nameController.text,
                        'phone': _phoneController.text,
                        'address': _addressController.text,
                        'city': _cityController.text,
                        'state': _stateController.text,
                        'zipCode': _zipCodeController.text,
                      };
                    }
                  });
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      address == null
                          ? 'Address added successfully'
                          : 'Address updated successfully',
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              address == null ? 'Add' : 'Save',
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

  Widget _buildDialogTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      enableInteractiveSelection: true,
      readOnly: false,
      decoration: InputDecoration(
        labelText: label,
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
      for (var address in _addresses) {
        address['isDefault'] = address['id'] == id;
      }
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Default address updated')));
  }

  void _showDeleteDialog(Map<String, dynamic> address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Address', style: AppTextStyles.h3),
        content: Text(
          'Are you sure you want to delete this address?',
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
                _addresses.removeWhere((a) => a['id'] == address['id']);
                if (_addresses.isNotEmpty && address['isDefault']) {
                  _addresses[0]['isDefault'] = true;
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Address deleted')));
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
