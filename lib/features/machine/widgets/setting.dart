import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_shop/features/machine/models/machine_manager.dart';
import 'package:coffee_shop/l10n/app_localizations.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.settings ?? 'Settings',
            style: const TextStyle(
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
                _buildSettingItem(context, AppLocalizations.of(context)?.general ?? 'General', () {}),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem(context, AppLocalizations.of(context)?.reminders ?? 'Reminders', () {}),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem(context, AppLocalizations.of(context)?.preferences ?? 'Preferences', () {}),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem(context, AppLocalizations.of(context)?.refillWaterBeans ?? 'Refill Water & Beans', () {
                  ref.read(machineProvider.notifier).refill();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)?.machineRefilled ?? 'Machine refilled!')),
                  );
                }),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _buildSettingItem(context, AppLocalizations.of(context)?.cleanMachine ?? 'Clean Machine', () {
                  ref.read(machineProvider.notifier).cleanMachine();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)?.machineCleaned ?? 'Machine cleaned!')),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black87),
      onTap: onTap,
    );
  }
}
