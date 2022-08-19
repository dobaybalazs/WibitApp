import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/borrowed_vests.dart' show BorrowedVests;
import '../widgets/vestitems/borrowed_vest.dart';

class BorrowedVestsScreen extends StatelessWidget {
  static const routeName = '/borrowed-vests';

  @override
  Widget build(BuildContext context) {
    final vests = Provider.of<BorrowedVests>(context);
    return vests.items.isEmpty
        ? Center(
            child: Text('Nincsen(ek) kölcsönzött mellény(ek)'),
          )
        : ListView.builder(
            itemCount: vests.items.length,
            itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
              value: vests.sortedItems[idx],
              child: BorrowedVest(),
              key: ValueKey(vests.sortedItems[idx].id),
            ),
          );
  }
}
