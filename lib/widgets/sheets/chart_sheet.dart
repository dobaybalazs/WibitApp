import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../other/chart_bar.dart';
import '../../providers/basic_vests.dart';

class ChartSheet extends StatelessWidget {
  Map<String, int> _quants = {
    'Mini': 0,
    'XS': 0,
    'S': 0,
    'M': 0,
    'L': 0,
    'XL': 0,
    'XXL': 0,
  };
  @override
  Widget build(BuildContext context) {
    final vests = Provider.of<BasicVests>(context);
    vests.vests.forEach(((element) => _quants[element.size] += 1));
    return Container(
      height: 300,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _quants.entries
            .map((e) => ChartBar(
                  name: e.key,
                  quant: e.value,
                  totalVestNum: vests.itemCount,
                ))
            .toList(),
      ),
    );
  }
}
