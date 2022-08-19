import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/daily_customers.dart' show DailyCustomers;
import '../widgets/other/customer.dart';

class DailyCustomersScreen extends StatelessWidget {
  static const routeName = '/daily-customers';

  @override
  Widget build(BuildContext context) {
    final customerData = Provider.of<DailyCustomers>(context);
    return customerData.customers.length == 0
        ? Center(
            child: Text('Nincsen(ek) mai vásárló(k)'),
          )
        : ListView.builder(
            itemCount: customerData.customers.length,
            itemBuilder: (context, idx) => Customer(
                customerData.customers.values.toList()[idx].name,
                customerData.customers.values.toList()[idx].arrivalTime,
                customerData.customers.values.toList()[idx].duration,
                customerData.customers.values.toList()[idx].number),
          );
  }
}
