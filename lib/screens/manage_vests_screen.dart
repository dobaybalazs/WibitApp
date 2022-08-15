import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/vestitems/basic_vest.dart';
import '../providers/basic_vests.dart' show BasicVests;

class ManageVestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vestsData = Provider.of<BasicVests>(context);
    return ListView.builder(
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: vestsData.vests[index],
        child: BasicVest(),
      ),
      itemCount: vestsData.itemCount,
    );
  }
}
