import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/borrowed_vests.dart' show BorrowedVests;
import '../widgets/vestitems/borrowed_vest.dart';

class BorrowedVestsScreen extends StatelessWidget {
  static const routeName = '/borrowed-vests';

  @override
  Widget build(BuildContext context) {
    return Consumer<BorrowedVests>(
      child: Center(
        child: Text('Nincsen(ek) kiadható mellény(ek)'),
      ),
      builder: (ctx, borrowedVests, ch) => borrowedVests.itemCount == 0
          ? ch
          : ListView.builder(
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: borrowedVests.items[index],
                child: BorrowedVest(),
              ),
              itemCount: borrowedVests.itemCount,
            ),
    );
  }
}
