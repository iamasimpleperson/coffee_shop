import 'package:coffee_shop/features/home/widgets/favourite_widget.dart';
import 'package:coffee_shop/features/home/widgets/schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/machine_bloc.dart';
import '../widgets/recommendation_widget.dart';
import '../widgets/api_test_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        // title: Builder(
        //   builder: (context) {
        //     final name = ref.watch(authProvider).currentUser?.name ?? AppLocalizations.of(context)?.guestMode ?? 'Guest';
        //     return Text(AppLocalizations.of(context)?.hello(name) ?? 'Hello, $name');
        //   },
        // ),
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
            RecommendationWidget(),
            SizedBox(height: 32),
            ApiTestWidget(),
            SizedBox(height: 32),
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
