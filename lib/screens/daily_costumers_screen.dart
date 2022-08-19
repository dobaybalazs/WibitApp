import 'package:flutter/material.dart';

import '../widgets/other/costumer.dart';

class DailyCostumersScreen extends StatelessWidget {
  static const routeName = '/daily-costumers';

  List<Costumer> costumers = [
    Costumer(),
    Costumer(),
    Costumer(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: costumers.length,
      itemBuilder: (context, index) => costumers[index],
    );
  }
}
