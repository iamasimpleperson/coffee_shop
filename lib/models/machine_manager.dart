import 'package:flutter/material.dart';

class MachineManager extends ChangeNotifier {
  int _cupsMade = 0;
  double _waterLevel = 1.0;
  double _beansLevel = 1.0;
  int _daysUntilClean = 30;
  DateTime _lastCleanedDate = DateTime.now();

  int get cupsMade => _cupsMade;
  double get waterLevel => _waterLevel;
  double get beansLevel => _beansLevel;
  int get daysUntilClean => _daysUntilClean;
  DateTime get lastCleanedDate => _lastCleanedDate;
  bool get hasCup => true; // For now, assume a cup is always available

  void makeCoffee() {
    _cupsMade++;
    _waterLevel = (_waterLevel - 0.1).clamp(0.0, 1.0);
    _beansLevel = (_beansLevel - 0.1).clamp(0.0, 1.0);
    
    // Decrease days until clean every 5 cups
    if (_cupsMade % 5 == 0) {
      _daysUntilClean = (_daysUntilClean - 1).clamp(0, 30);
    }
    notifyListeners();
  }

  void refill() {
    _waterLevel = 1.0;
    _beansLevel = 1.0;
    notifyListeners();
  }

  void cleanMachine() {
    _daysUntilClean = 30;
    _lastCleanedDate = DateTime.now();
    notifyListeners();
  }
}

// Global instance for simple access
final machineManager = MachineManager();
