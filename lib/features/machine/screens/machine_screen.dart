import 'package:coffee_shop/features/machine/widgets/machine_options.dart';
import 'package:coffee_shop/features/machine/widgets/machine_summary.dart';
import 'package:coffee_shop/features/machine/widgets/setting.dart';
import 'package:coffee_shop/features/machine/widgets/statistic.dart';
import 'package:coffee_shop/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MachineScreen extends StatefulWidget {
  const MachineScreen({super.key});

  @override
  State<MachineScreen> createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.home);
            }
          },
        ),
        title: const Text('Name Machine'),
        actions: [Icon(Icons.info), SizedBox(width: 20)],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 250),
            MachineOptions(),
            MachineSummary(),
            SettingsWidget(),
            StatisticsWidget(),
          ],
        ),
      ),
    );
  }
}
