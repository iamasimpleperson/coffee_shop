import 'package:flutter_riverpod/flutter_riverpod.dart';

class MachineState {
  final int cupsMade;
  final double waterLevel;
  final double beansLevel;
  final int daysUntilClean;
  final DateTime lastCleanedDate;
  final bool hasCup;

  MachineState({
    this.cupsMade = 0,
    this.waterLevel = 1.0,
    this.beansLevel = 1.0,
    this.daysUntilClean = 30,
    DateTime? lastCleanedDate,
    this.hasCup = true,
  }) : lastCleanedDate = lastCleanedDate ?? DateTime.now();

  MachineState copyWith({
    int? cupsMade,
    double? waterLevel,
    double? beansLevel,
    int? daysUntilClean,
    DateTime? lastCleanedDate,
    bool? hasCup,
  }) {
    return MachineState(
      cupsMade: cupsMade ?? this.cupsMade,
      waterLevel: waterLevel ?? this.waterLevel,
      beansLevel: beansLevel ?? this.beansLevel,
      daysUntilClean: daysUntilClean ?? this.daysUntilClean,
      lastCleanedDate: lastCleanedDate ?? this.lastCleanedDate,
      hasCup: hasCup ?? this.hasCup,
    );
  }
}

class MachineNotifier extends Notifier<MachineState> {
  @override
  MachineState build() {
    return MachineState();
  }

  void makeCoffee() {
    final cups = state.cupsMade + 1;
    final water = (state.waterLevel - 0.1).clamp(0.0, 1.0);
    final beans = (state.beansLevel - 0.1).clamp(0.0, 1.0);
    int days = state.daysUntilClean;
    
    if (cups % 5 == 0) {
      days = (days - 1).clamp(0, 30);
    }
    
    state = state.copyWith(
      cupsMade: cups,
      waterLevel: water,
      beansLevel: beans,
      daysUntilClean: days,
    );
  }

  void refill() {
    state = state.copyWith(waterLevel: 1.0, beansLevel: 1.0);
  }

  void cleanMachine() {
    state = state.copyWith(
      daysUntilClean: 30,
      lastCleanedDate: DateTime.now(),
    );
  }
}

final machineProvider = NotifierProvider<MachineNotifier, MachineState>(() {
  return MachineNotifier();
});

