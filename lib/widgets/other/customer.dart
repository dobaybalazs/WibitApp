import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Customer extends StatefulWidget {
  final String name;
  final DateTime arrivalTime;
  final Duration duration;
  final int number;
  final SvgPicture signature;

  Customer(
      this.name, this.arrivalTime, this.duration, this.number, this.signature);
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
      subtitle: Text('Szám:${widget.number}'),
      trailing: Text(
          '${DateFormat('Hm').format(widget.arrivalTime)} - ${DateFormat('Hm').format(widget.arrivalTime.add(widget.duration))}'),
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
                      color: Colors.black12,
                      width: double.infinity,
                      height: 200,
                      child: widget.signature,
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
