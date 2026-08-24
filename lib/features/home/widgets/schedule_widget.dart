import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/schedule_manager.dart';
import 'add_schedule_bottom_sheet.dart';
import 'package:coffee_shop/routes/auth_notifier.dart';
import 'package:go_router/go_router.dart';

class ScheduleWidget extends ConsumerWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Schedule',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                if (!ref.read(authProvider).isAuthenticated) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Required'),
                      content: const Text('Please log in to add schedules.'),
                      actions: [
                        TextButton(onPressed: () => context.pop(), child: const Text('Back')),
                        ElevatedButton(
                          onPressed: () {
                            context.pop();
                            context.push('/login');
                          },
                          child: const Text('Log In'),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useRootNavigator: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddScheduleBottomSheet(),
                );
              },
              icon: const Icon(Icons.add_circle_outline, size: 28),
              color: Colors.black54,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Builder(
          builder: (context) {
            final schedules = ref.watch(scheduleProvider);
            if (schedules.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No schedules yet. Create one!',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true, // Prevents layout crash inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];

                return GestureDetector(
                  onTap: () {
                    if (!ref.read(authProvider).isAuthenticated) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Login Required'),
                          content: const Text('Please log in to edit schedules.'),
                          actions: [
                            TextButton(onPressed: () => context.pop(), child: const Text('Back')),
                            ElevatedButton(
                              onPressed: () {
                                context.pop();
                                context.push('/login');
                              },
                              child: const Text('Log In'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => AddScheduleBottomSheet(existingSchedule: schedule),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  child: Row(
                    children: [
                      // Safe Placeholder Image/Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.alarm,
                            color: Color(0xFF6AC79E),
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Schedule Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                schedule.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                            const SizedBox(height: 4),
                              Text(
                                '${schedule.isRepeat ? 'Repeating' : 'One-time'} • ${schedule.time.format(context)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Toggle Switch
                      Switch(
                        value: schedule.isActive,
                        onChanged: (bool value) {
                          if (!ref.read(authProvider).isAuthenticated) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Login Required'),
                                content: const Text('Please log in to manage schedules.'),
                                actions: [
                                  TextButton(onPressed: () => context.pop(), child: const Text('Back')),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.pop();
                                      context.push('/login');
                                    },
                                    child: const Text('Log In'),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }
                          ref.read(scheduleProvider.notifier).toggleSchedule(schedule.id, value);
                        },
                        activeColor: Colors.white,
                        activeTrackColor: const Color(0xFF6AC79E),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              );
            },
            );
          },
        ),
      ],
    );
  }
}
