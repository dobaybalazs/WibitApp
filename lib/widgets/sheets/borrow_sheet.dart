import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/borrowed_vests.dart' show BorrowedVests;
import '../../providers/basic_vests.dart';
import '../../providers/daily_customers.dart';

class BorrowSheet extends StatefulWidget {
  final int id;
  final String size;

  BorrowSheet({@required this.id, @required this.size});

  @override
  State<BorrowSheet> createState() => _BorrowSheetState();
}

class _BorrowSheetState extends State<BorrowSheet> {
  double _timerValue = 0;

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final borrowedVs = Provider.of<BorrowedVests>(context, listen: false);
    final customers = Provider.of<DailyCustomers>(context, listen: false);
    final basicvs = Provider.of<BasicVests>(context, listen: false);
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
                label: Text(
                  'Név:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
              onPressed: () {
                if (_nameController.text != '') {
                  borrowedVs.borrowVest(widget.id, _nameController.text,
                      widget.size, _timerValue.toInt() * 5);
                  customers.addCustomer(_nameController.text, 11,
                      _timerValue.toInt() * 5, widget.id);
                  basicvs.removeLifejacket(widget.id);
                  Navigator.pop(context);
                }
              },
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
