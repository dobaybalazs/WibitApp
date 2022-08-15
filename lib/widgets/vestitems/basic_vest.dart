import 'package:flutter/material.dart';

import '../sheets/borrow_sheet.dart';

class BasicVest extends StatelessWidget {
  final int id;

  BasicVest({@required this.id});

  void startBorrowingVest(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) => GestureDetector(
        child: BorrowSheet(),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 35,
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      child: InkWell(
        onTap: () {
          startBorrowingVest(context);
        },
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
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
                'Méret S',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Szám: 56',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
