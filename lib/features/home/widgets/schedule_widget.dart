import 'package:flutter/material.dart';
import '../../../models/schedule_manager.dart';
import 'add_schedule_bottom_sheet.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        ValueListenableBuilder<List<ScheduleModel>>(
          valueListenable: ScheduleManager.schedulesNotifier,
          builder: (context, schedules, child) {
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
                      color: const Color(0xFFF6F7F9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  child: Row(
                    children: [
                      // Safe Placeholder Image/Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${schedule.isRepeat ? 'Repeating' : 'One-time'} • ${schedule.time.format(context)}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
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
                          ScheduleManager.toggleSchedule(schedule.id, value);
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
