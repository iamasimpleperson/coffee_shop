import 'package:coffee_shop/features/home/widgets/favourite_widget.dart';
import 'package:coffee_shop/features/home/widgets/schedule_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/machine_bloc.dart';

import 'package:coffee_shop/routes/auth_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_shop/routes/route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: ListenableBuilder(
          listenable: authNotifier,
          builder: (context, _) {
            final name = authNotifier.currentUser?.name ?? 'Guest';
            return Text('Hello, $name');
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => context.go('/profile'),
            child: const CircleAvatar(child: Icon(Icons.person)),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            MachineBloc(),
            SizedBox(height: 32),
            FavouriteWidget(),
            SizedBox(height: 32),
            ScheduleWidget(),
          ],
        ),
      ),
    );
  }
}
