import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

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

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2.5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.grey,
    exportPenColor: Colors.black,
  );

  @override
  void initState() {
    _signatureController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

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
          SizedBox(
            height: 10,
          ),
          Signature(
            controller: _signatureController,
            width: mediaQuery.size.width * 0.9,
            height: mediaQuery.size.height * 0.3,
            backgroundColor: Colors.black12,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                String signature = null;
                if (_signatureController.toRawSVG() != null) {
                  signature = "";
                  var string = _signatureController.toRawSVG().split('>');
                  string.removeWhere(
                    (element) => !element.contains('points'),
                  );
                  if (string.length > 1) {
                    var prevLine = <String>[];
                    final svgLine =
                        RegExp(r'points="(\b[^"]*)"', multiLine: true);
                    for (var line in string) {
                      final myMatch = svgLine.firstMatch(line);
                      prevLine.add(myMatch.group(1));
                    }
                    final list = [];
                    list.add(prevLine[0]);
                    for (var j = 1; j < prevLine.length; ++j) {
                      list.add(prevLine[j].substring(prevLine[j - 1].length));
                    }
                    var seqend = <String>[];
                    for (var j = 0; j < string.length; ++j) {
                      var newLine = string[j].split('"');
                      for (var i = 0; i < newLine.length - 1; ++i) {
                        if (newLine[i].contains('points=')) {
                          newLine[i + 1] = list[j];
                        }
                      }
                      var addedS = '';
                      for (var word in newLine) {
                        addedS += word;
                        addedS += '"';
                      }
                      seqend.add(addedS.substring(0, addedS.length - 1) + '>');
                    }
                    signature +=
                        '<svg viewBox="0 0 297 174" xmlns="http://www.w3.org/2000/svg">';
                    for (var line in seqend) {
                      signature += line;
                    }
                    signature += "\n</svg>";
                  } else {
                    signature = _signatureController.toRawSVG();
                  }
                }
                if (_nameController.text != '') {
                  var currentTime = DateTime.now();
                  var basicTime = DateTime(0);
                  borrowedVs.borrowVest(
                    widget.id,
                    _nameController.text,
                    currentTime.toString(),
                    widget.size,
                    Duration(minutes: _timerValue.toInt() * 5),
                  );
                  customers.addCustomer(
                    _nameController.text,
                    currentTime,
                    widget.id,
                    signature,
                    basicTime,
                  );
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
