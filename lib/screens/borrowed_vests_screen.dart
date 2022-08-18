import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/borrowed_vests.dart' show BorrowedVests;
import '../widgets/vestitems/borrowed_vest.dart';

class BorrowedVestsScreen extends StatelessWidget {
  static const routeName = '/borrowed-vests';

  @override
  Widget build(BuildContext context) {
    final vests = Provider.of<BorrowedVests>(context);
    return ListView.builder(
      itemCount: vests.items.length,
      itemBuilder: (ctx, idx) => BorrowedVest(
        id: vests.items[idx].id,
        name: vests.items[idx].name,
        size: vests.items[idx].size,
        duration: vests.items[idx].duration,
      ),
    );
  }
}
