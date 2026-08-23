import 'package:coffee_shop/features/home/widgets/favourite_widget.dart';
import 'package:coffee_shop/features/home/widgets/schedule_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/machine_bloc.dart';

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
        title: const Text('Hello, name'),
        actions: const [CircleAvatar(), SizedBox(width: 20)],
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
