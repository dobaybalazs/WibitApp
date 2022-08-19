import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/basic_vests.dart';


class AddVestSheet extends StatefulWidget {
  @override
  State<AddVestSheet> createState() => _AddVestSheetState();
}

class _AddVestSheetState extends State<AddVestSheet> {
  String _dropdownValue = 'Mini';

  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vests = Provider.of<BasicVests>(context, listen: false);
    
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: DropdownButton(
                    underline: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                    value: _dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        _dropdownValue = newValue;
                      });
                    },
                    items: <String>['Mini', 'XS', 'S', 'M', 'L', 'XL', 'XXL']
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 16),
                            ),
                            value: value,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  width: 150,
                  child: TextField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text(
                        'Mellény szám',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (_numberController.text != '') {
                      vests.addNewLifejacket(
                          _dropdownValue, int.parse(_numberController.text));
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(Icons.check),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
