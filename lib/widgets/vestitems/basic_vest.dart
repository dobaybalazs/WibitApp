import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sheets/borrow_sheet.dart';
import '../../providers/basic_vests.dart';

class BasicVest extends StatelessWidget {
  void startBorrowingVest(BuildContext ctx, int id, String size) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) => GestureDetector(
        child: BorrowSheet(id: id, size: size),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vest = Provider.of<BasicLifejacket>(context, listen: false);
    final currentVests = Provider.of<BasicVests>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          currentVests.removeLifejacket(vest.id);
        },
        key: ValueKey(vest.id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete_sweep,
            color: Colors.white,
            size: 35,
          ),
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),
        child: InkWell(
          onTap: () {
            startBorrowingVest(context, vest.id, vest.size);
          },
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: ListTile(
                horizontalTitleGap: 30,
                leading: Image.asset(
                  'assets/images/lifejacket.jpg',
                  fit: BoxFit.cover,
                  height: 56,
                ),
                title: Text(
                  '${vest.size}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  'Szám: ${vest.id}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
