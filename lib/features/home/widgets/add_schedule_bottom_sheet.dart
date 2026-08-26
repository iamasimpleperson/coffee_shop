import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/schedule_manager.dart';
import 'package:coffee_shop/l10n/app_localizations.dart';

class AddScheduleBottomSheet extends ConsumerStatefulWidget {
  final ScheduleModel? existingSchedule;

  const AddScheduleBottomSheet({super.key, this.existingSchedule});

  @override
  ConsumerState<AddScheduleBottomSheet> createState() => _AddScheduleBottomSheetState();
}

class _AddScheduleBottomSheetState extends ConsumerState<AddScheduleBottomSheet> {
  late final TextEditingController _nameController;
  late TimeOfDay _selectedTime;
  late bool _isRepeat;
  late List<int> _selectedDays;

  final List<Map<String, dynamic>> _daysOfWeek = [
    {'name': 'Mon', 'val': 1},
    {'name': 'Tue', 'val': 2},
    {'name': 'Wed', 'val': 3},
    {'name': 'Th', 'val': 4},
    {'name': 'Fri', 'val': 5},
    {'name': 'Sat', 'val': 6},
    {'name': 'Sun', 'val': 7},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingSchedule != null) {
      _nameController = TextEditingController(text: widget.existingSchedule!.title);
      _selectedTime = widget.existingSchedule!.time;
      _isRepeat = widget.existingSchedule!.isRepeat;
      _selectedDays = List.from(widget.existingSchedule!.repeatDays);
    } else {
      _nameController = TextEditingController(text: 'My latte');
      _selectedTime = TimeOfDay.now();
      _isRepeat = true;
      _selectedDays = [1, 5]; // Default Mon, Fri
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveSchedule() {
    final schedule = ScheduleModel(
      id: widget.existingSchedule?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _nameController.text.trim().isEmpty ? 'My Coffee' : _nameController.text.trim(),
      time: _selectedTime,
      isRepeat: _isRepeat,
      repeatDays: List.from(_selectedDays),
      isActive: widget.existingSchedule?.isActive ?? true,
    );

    if (widget.existingSchedule != null) {
      ref.read(scheduleProvider.notifier).updateSchedule(schedule);
    } else {
      ref.read(scheduleProvider.notifier).addSchedule(schedule);
    }
    
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine AM/PM string formatting
    final String timeStr = _selectedTime.format(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle for bottom sheet
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Header
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF2D0), // Light yellow bg for icon
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.alarm, color: Color(0xFF9080F0), size: 36),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)?.schedule ?? 'Schedule',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)?.setPerfectTime ?? 'Set the perfect time for your coffee.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Short Name
            Text(AppLocalizations.of(context)?.shortName ?? 'Short name', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF6F7F9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Time
            Text(AppLocalizations.of(context)?.time ?? 'Time', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickTime,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.black87),
                    const SizedBox(width: 12),
                    Text(
                      '${AppLocalizations.of(context)?.today ?? "Today"}, $timeStr',
                      style: const TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Repeat
            Text(AppLocalizations.of(context)?.repeat ?? 'Repeat', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.createRoutine ?? 'Create your coffee routine',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            AppLocalizations.of(context)?.letMakerHandle ?? 'Let the maker handle the rest.',
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),
                      Switch(
                        value: _isRepeat,
                        onChanged: (val) {
                          setState(() {
                            _isRepeat = val;
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.black,
                      ),
                    ],
                  ),
                  if (_isRepeat) ...[
                    const Divider(height: 24, thickness: 1, color: Color(0xFFE5E7EB)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _daysOfWeek.map((day) {
                        final isSelected = _selectedDays.contains(day['val']);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedDays.remove(day['val']);
                              } else {
                                _selectedDays.add(day['val']);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? Colors.black : Colors.grey[300]!,
                              ),
                            ),
                            child: Text(
                              day['name'],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _saveSchedule,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)?.save ?? 'Save',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
