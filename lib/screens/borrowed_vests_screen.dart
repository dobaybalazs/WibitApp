import 'package:flutter/material.dart';

import '../widgets/vestitems/borrowed_vest.dart';

class BorrowedVestsScreen extends StatelessWidget {
  List<BorrowedVest> vests = [
    BorrowedVest(id: 1),
    BorrowedVest(id: 2),
    BorrowedVest(id: 3),
  ];

  static const routeName = '/borrowed-vests';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vests.length,
      itemBuilder: (ctx, idx) => vests[idx],
    );
  }
}
