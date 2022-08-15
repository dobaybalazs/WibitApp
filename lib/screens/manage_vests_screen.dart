import 'package:flutter/material.dart';

import '../widgets/vestitems/basic_vest.dart';

class ManageVestsScreen extends StatelessWidget {
  List<BasicVest> vests = [
    BasicVest(id: 1),
    BasicVest(id: 2),
    BasicVest(id: 3),
    BasicVest(id: 4),
    BasicVest(id: 5),
    BasicVest(id: 6),
    BasicVest(id: 7),
    BasicVest(id: 8),
    BasicVest(id: 9),
    BasicVest(id: 10),
    BasicVest(id: 11),
    BasicVest(id: 12),
    BasicVest(id: 13),
    BasicVest(id: 14),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) => vests[index]),
      itemCount: vests.length,
    );
  }
}
