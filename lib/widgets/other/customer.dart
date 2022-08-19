import 'package:flutter/material.dart';

class Customer extends StatefulWidget {
  final String name;
  final int arrivalTime;
  final int duration;
  final int number;

  Customer(this.name, this.arrivalTime, this.duration, this.number);
  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  Widget _listTileBuilder() {
    return ListTile(
      leading: Icon(
        Icons.account_circle_outlined,
        color: Theme.of(context).colorScheme.primary,
        size: 38,
      ),
      title: Text(widget.name),
      subtitle: Text('${widget.number}'),
      trailing: Text('${widget.arrivalTime} - ${widget.duration}'),
    );
  }

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return _isExpanded
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            key: ValueKey(DateTime.now().toString() + widget.number.toString()),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Card(
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    _listTileBuilder(),
                    Divider(
                      thickness: 1.0,
                      indent: 15.0,
                      endIndent: 15.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5,
                        left: 5,
                        right: 5,
                      ),
                      color: Colors.black45,
                      width: double.infinity,
                      height: 150,
                    )
                  ],
                ),
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            key: ValueKey(DateTime.now()),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Card(
                elevation: 3,
                child: _listTileBuilder(),
              ),
            ),
          );
  }
}
