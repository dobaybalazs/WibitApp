import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyCustomer {
  final String name;
  final DateTime arrivalTime;
  final Duration duration;
  final int number;
  final SvgPicture signature;

  DailyCustomer({
    @required this.name,
    @required this.arrivalTime,
    @required this.duration,
    @required this.number,
    @required this.signature,
  });
}

class DailyCustomers with ChangeNotifier {
  Map<String, DailyCustomer> _customers = {};

  Map<String, DailyCustomer> get customers {
    return {..._customers};
  }

  void addCustomer(String name, DateTime arrivalTime, Duration duration, int number,
      SvgPicture signature) {
    _customers[DateTime.now().toString()] = DailyCustomer(
      name: name,
      arrivalTime: arrivalTime,
      duration: duration,
      number: number,
      signature: signature,
    );
    notifyListeners();
  }

  void deleteAllCustomers() {
    _customers.clear();
    notifyListeners();
  }
}