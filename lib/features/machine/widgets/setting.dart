import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
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
            clipBehavior: Clip.antiAlias, // Ensures ink splash respects rounded corners
            child: Column(
              children: [
                _buildSettingItem('General'),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem('Reminders'),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem('Preferences'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black87),
      onTap: () {},
    );
  }
}
