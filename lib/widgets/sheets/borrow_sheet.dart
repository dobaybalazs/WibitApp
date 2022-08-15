import 'dart:io';

import 'package:flutter/material.dart';

class BorrowSheet extends StatefulWidget {
  const BorrowSheet({Key key}) : super(key: key);

  @override
  State<BorrowSheet> createState() => _BorrowSheetState();
}

class _BorrowSheetState extends State<BorrowSheet> {
  double _timerValue = 0;

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.6,
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Idő:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Slider(
                  value: _timerValue,
                  onChanged: (newValue) {
                    setState(() {
                      _timerValue = newValue;
                    });
                  },
                  activeColor: Theme.of(context).colorScheme.secondary,
                  inactiveColor: Color.fromRGBO(0, 150, 0, 0.2),
                  min: 0,
                  max: 18,
                  divisions: 18,
                  label: "${_timerValue.toInt() * 5}",
                ),
              ),
              Text('${_timerValue.toInt() * 5} perc'),
            ],
          ),
          Container(
            width: mediaQuery.size.width * 0.9,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Név:',
              ),
              controller: _nameController,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 200,
            width: double.infinity,
            color: Colors.black12,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Kölcsönzés'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
