import 'package:flutter/material.dart';

class DailyCostumer {
  final String name;
  final int arrivalTime;
  final int duration;
  final int number;

  DailyCostumer({
    @required this.name,
    @required this.arrivalTime,
    @required this.duration,
    @required this.number,
  });
}

class DailyCostumers with ChangeNotifier {
  Map<String, DailyCostumer> _costumers = {};

  Map<String, DailyCostumer> get costumer {
    return {..._costumers};
  }

  void addCostumer(String name, int arrivalTime, int duration, int number) {
    _costumers[DateTime.now().toString()] = DailyCostumer(
      name: name,
      arrivalTime: arrivalTime,
      duration: duration,
      number: number,
    );
    notifyListeners();
  }

  void deleteAllCostumers() {
    _costumers.clear();
    notifyListeners();
  }
}
