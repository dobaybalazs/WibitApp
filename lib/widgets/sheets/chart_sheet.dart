import 'package:flutter/material.dart';

import '../other/chart_bar.dart';

class ChartSheet extends StatefulWidget {
  const ChartSheet({Key key}) : super(key: key);

  @override
  State<ChartSheet> createState() => _ChartSheetState();
}

class _ChartSheetState extends State<ChartSheet> {
  Map<String, int> _quants = {
    'Mini': 15,
    'XS': 10,
    'S': 8,
    'M': 2,
    'L': 20,
    'XL': 22,
    'XXL': 2
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _quants.entries.map((e) => ChartBar(name:e.key,quant:e.value)).toList(),
      ),
    );
  }
}
