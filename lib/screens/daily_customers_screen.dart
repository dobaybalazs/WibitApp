import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/daily_customers.dart' show DailyCustomers;
import '../widgets/other/customer.dart';

class DailyCustomersScreen extends StatelessWidget {
  static const routeName = '/daily-customers';

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyCustomers>(
      child: Center(
        child: Text('Nincsen(ek) mai vásárló(k)'),
      ),
      builder: (ctx, dailyCustomers, ch) => dailyCustomers.itemCount == 0
          ? ch
          : ListView.builder(
              itemCount: dailyCustomers.itemCount,
              itemBuilder: (context, idx) => ChangeNotifierProvider.value(
                value: dailyCustomers.customers[idx],
                child: Customer(),
              ),
            ),
    );
  }
}
