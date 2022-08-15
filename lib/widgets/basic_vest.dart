import 'package:flutter/material.dart';

class BasicVest extends StatelessWidget {
  final int id;

  BasicVest({@required this.id});

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
        onTap: () {},
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
              title: const Text(
                'Méret S',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: const Text(
                'Szám: 56',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
