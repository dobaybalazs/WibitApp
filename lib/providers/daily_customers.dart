import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';

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
    this.expdate,
  });
}

class DailyCustomers with ChangeNotifier {
  List<DailyCustomer> _customers = [];

  DailyCustomers(this._customers);

  List<DailyCustomer> get customers {
    return [..._customers];
  }

  int get itemCount {
    return _customers.length;
  }

  Future<void> fetchAndSetDailyCustomers() async {
    final dataList = await DBHelper.getData('daily_customers');
    _customers = dataList
        .map(
          (e) => DailyCustomer(
            arrivalTime: DateTime.parse(e['arrivalTime']),
            name: e['name'],
            number: e['number'],
            signature: e['signature'],
            expdate: DateTime.parse(e['expdate']),
          ),
        )
        .toList();
    notifyListeners();
  }

  void addCustomer(String name, DateTime arrivalTime, int number,
      String signature, DateTime expdate) {
    _customers.add(
      DailyCustomer(
          name: name,
          arrivalTime: arrivalTime,
          number: number,
          signature: signature,
          expdate: expdate),
    );
    notifyListeners();
    DBHelper.insert('daily_customers', {
      'arrivalTime': arrivalTime.toString(),
      'name': name,
      'number': number,
      'signature': signature,
      'expdate': expdate.toString(),
    });
  }

  void deleteCostumer(DateTime arrivalTime) {
    if (_customers.any((element) => element.arrivalTime == arrivalTime)) {
      _customers.removeWhere((element) => element.arrivalTime == arrivalTime);
    }
    notifyListeners();
    DBHelper.removeS('daily_customers', arrivalTime.toString());
  }

  void deleteAllCustomers() {
    _customers.clear();
    notifyListeners();
    DBHelper.removeAll('daily_customers');
  }

  void setExpDate(String arrivalTime) {
    if (_customers
        .any((element) => element.arrivalTime.toString() == arrivalTime)) {
      _customers
          .firstWhere(
              (element) => element.arrivalTime.toString() == arrivalTime)
          .expdate = DateTime.now();
      DBHelper.updateData(
          'daily_customers', DateTime.now().toString(), arrivalTime);
      notifyListeners();
    }
  }
}
