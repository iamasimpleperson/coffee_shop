import 'package:flutter/material.dart';

class MachineOptions extends StatelessWidget {
  const MachineOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildOption(context, Icons.water_drop_outlined, 'Rinse'),
        _buildOption(context, Icons.bedtime_outlined, 'Sleep'),
        _buildOption(context, Icons.cleaning_services_outlined, 'Clean'),
      ],
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF6F7F9),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28, color: Colors.black87),
        ),

        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
