import 'package:flutter/material.dart';
import '../../../models/checkout_manager.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final TextEditingController _firstNameController = TextEditingController(text: 'John');
  final TextEditingController _surnameController = TextEditingController(text: 'Doe');
  final TextEditingController _postCodeController = TextEditingController(text: 'W1B 3EL');
  final TextEditingController _addressController = TextEditingController(text: '226 Regent Street');
  final TextEditingController _countyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController(text: 'London');

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _postCodeController.dispose();
    _addressController.dispose();
    _countyController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onDone() {
    final address = AddressData(
      firstName: _firstNameController.text.trim(),
      surname: _surnameController.text.trim(),
      postCode: _postCodeController.text.trim(),
      address: _addressController.text.trim(),
      county: _countyController.text.trim(),
      city: _cityController.text.trim(),
    );
    CheckoutManager.setAddress(address);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Shipping address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            
            _buildTextField('First name', _firstNameController),
            _buildTextField('Surname', _surnameController),
            _buildTextField('Post code', _postCodeController),
            _buildTextField('Address', _addressController),
            _buildTextField('County (optional)', _countyController),
            _buildTextField('City', _cityController),
            
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF6F7F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
