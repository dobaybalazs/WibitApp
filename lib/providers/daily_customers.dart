import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyCustomer {
  final String name;
  final DateTime arrivalTime;
  DateTime expdate = DateTime(0);
  final int number;
  final SvgPicture signature;

  DailyCustomer({
    @required this.name,
    @required this.arrivalTime,
    @required this.number,
    @required this.signature,
  });
}

class DailyCustomers with ChangeNotifier {
  Map<String, DailyCustomer> _customers = {};

  Map<String, DailyCustomer> get customers {
    return {..._customers};
  }

  void addCustomer(
      String name, DateTime arrivalTime, int number, SvgPicture signature) {
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
            .any((element) => element.arrivalTime.toString() == arrivalTime) !=
        null) {
      _customers.values
          .firstWhere(
              (element) => element.arrivalTime.toString() == arrivalTime)
          .expdate = DateTime.now();
    }
    notifyListeners();
  }
}
