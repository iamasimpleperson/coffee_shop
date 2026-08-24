import 'package:coffee_shop/features/machine/widgets/machine_options.dart';
import 'package:coffee_shop/features/machine/widgets/machine_summary.dart';
import 'package:coffee_shop/features/machine/widgets/setting.dart';
import 'package:coffee_shop/features/machine/widgets/statistic.dart';
import 'package:coffee_shop/models/machine_manager.dart';
import 'package:coffee_shop/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MachineScreen extends ConsumerWidget {
  const MachineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Builder(
              builder: (context) {
                final machine = ref.watch(machineProvider);
                return Column(
                  children: [
                    MachineSummary(
                      waterLevel: machine.waterLevel,
                      beansLevel: machine.beansLevel,
                      hasCup: machine.hasCup,
                      daysUntilClean: machine.daysUntilClean,
                    ),
                    SettingsWidget(),
                    StatisticsWidget(
                      cupsMade: machine.cupsMade,
                      lastCleaned: machine.lastCleanedDate,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
