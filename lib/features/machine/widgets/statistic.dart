import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticsWidget extends StatelessWidget {
  final int cupsMade;
  final DateTime lastCleaned;

  const StatisticsWidget({
    super.key,
    required this.cupsMade,
    required this.lastCleaned,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _buildSettingItem('Made Cofe', '$cupsMade'),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem('Time in used', '1 day'),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem('Cleaned', dateFormat.format(lastCleaned)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String amount) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: Text(
        amount,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      onTap: () {},
    );
  }
}
