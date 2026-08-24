import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes/app_routes.dart';

class ScheduleModel {
  final String id;
  final String title;
  final TimeOfDay time;
  final bool isRepeat;
  final List<int> repeatDays; // 1 = Monday, 7 = Sunday
  bool isActive;
  bool hasAlertedToday; // Prevent multiple alerts in the same minute

  ScheduleModel({
    required this.id,
    required this.title,
    required this.time,
    required this.isRepeat,
    required this.repeatDays,
    this.isActive = true,
    this.hasAlertedToday = false,
  });
}

class ScheduleNotifier extends Notifier<List<ScheduleModel>> {
  Timer? _timer;

  @override
  List<ScheduleModel> build() {
    return [];
  }

  void init() {
    // Check every 10 seconds to ensure we don't miss the minute mark
    _timer ??= Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkSchedules();
    });
  }

  void addSchedule(ScheduleModel schedule) {
    final current = List<ScheduleModel>.from(state);
    current.add(schedule);
    state = current;
  }

  void updateSchedule(ScheduleModel updatedSchedule) {
    final current = List<ScheduleModel>.from(state);
    final index = current.indexWhere((s) => s.id == updatedSchedule.id);
    if (index != -1) {
      current[index] = updatedSchedule;
      state = current;
    }
  }

  void toggleSchedule(String id, bool isActive) {
    final current = List<ScheduleModel>.from(state);
    final index = current.indexWhere((s) => s.id == id);
    if (index != -1) {
      current[index].isActive = isActive;
      current[index].hasAlertedToday = false; // Reset when toggled
      state = current;
    }
  }

  void _checkSchedules() {
    final now = DateTime.now();
    final currentDay = now.weekday; // 1 = Monday, 7 = Sunday

    for (var schedule in state) {
      if (!schedule.isActive) continue;

      // Check if it's the right day
      if (schedule.isRepeat && !schedule.repeatDays.contains(currentDay)) {
        continue;
      }

      if (schedule.time.hour == now.hour &&
          schedule.time.minute == now.minute) {
        if (!schedule.hasAlertedToday) {
          schedule.hasAlertedToday = true;
          _showAlert(schedule);
        }
      } else {
        // Reset the alert flag if time has passed so it works tomorrow
        schedule.hasAlertedToday = false;
      }
    }
  }

  void _showAlert(ScheduleModel schedule) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Coffee Time!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.coffee, size: 64, color: Colors.brown),
              const SizedBox(height: 16),
              Text(
                'It is time for your scheduled coffee:\n${schedule.title}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Dismiss',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

final scheduleProvider = NotifierProvider<ScheduleNotifier, List<ScheduleModel>>(() {
  return ScheduleNotifier();
});
