import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyCustomer with ChangeNotifier {
  final String name;
  final DateTime arrivalTime;
  DateTime expdate = DateTime(0);
  final int number;
  final String signature;

  DailyCustomer({
    @required this.name,
    @required this.arrivalTime,
    @required this.number,
    @required this.signature,
  });
}

class DailyCustomers with ChangeNotifier {
  Map<String, DailyCustomer> _customers = {};

  List<DailyCustomer> get customers {
    return [..._customers.values.toList()];
  }

  int get itemCount {
    return _customers.length;
  }

  void addCustomer(
      String name, DateTime arrivalTime, int number, String signature) {
    _customers[arrivalTime.toString()] = DailyCustomer(
      name: name,
      arrivalTime: arrivalTime,
      number: number,
      signature: signature,
    );
    notifyListeners();
  }

  void deleteCostumer(DateTime arrivalTime) {
    _customers.remove(arrivalTime.toString());
    notifyListeners();
  }

  void deleteAllCustomers() {
    _customers.clear();
    notifyListeners();
  }

  void setExpDate(String arrivalTime) {
    if (_customers.values
        .any((element) => element.arrivalTime.toString() == arrivalTime)) {
      _customers.values
          .firstWhere(
              (element) => element.arrivalTime.toString() == arrivalTime)
          .expdate = DateTime.now();
      notifyListeners();
    }
  }
}
