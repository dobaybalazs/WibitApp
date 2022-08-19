import 'package:flutter/material.dart';

class DailyCustomer {
  final String name;
  final int arrivalTime;
  final int duration;
  final int number;

  DailyCustomer({
    @required this.name,
    @required this.arrivalTime,
    @required this.duration,
    @required this.number,
  });
}

class DailyCustomers with ChangeNotifier {
  Map<String, DailyCustomer> _customers = {};

  Map<String, DailyCustomer> get customers {
    return {..._customers};
  }

  void addCustomer(String name, int arrivalTime, int duration, int number) {
    _customers[DateTime.now().toString()] = DailyCustomer(
      name: name,
      arrivalTime: arrivalTime,
      duration: duration,
      number: number,
    );
    notifyListeners();
  }

  void deleteAllCustomers() {
    _customers.clear();
    notifyListeners();
  }
}
