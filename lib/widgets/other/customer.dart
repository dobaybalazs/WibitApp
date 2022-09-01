import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/daily_customers.dart';

class Customer extends StatefulWidget {
  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  Widget _listTileBuilder(DailyCustomer customer) {
    return ListTile(
      leading: Icon(
        Icons.account_circle_outlined,
        color: Theme.of(context).colorScheme.primary,
        size: 38,
      ),
      title: Text(customer.name),
      subtitle: Text('Szám:${customer.number}'),
      trailing: FittedBox(
        child: Row(
          children: <Widget>[
            Text(
                '${DateFormat('Hm').format(customer.arrivalTime)} - ${customer.expdate.year == 0 ? '' : DateFormat('Hm').format(customer.expdate)}'),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Törli a kiválasztott vásárlót?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Nem'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<DailyCustomers>(context, listen: false)
                              .deleteCostumer(customer.arrivalTime);
                        },
                        child: Text('Igen'),
                      )
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete_outline),
              iconSize: 30,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<DailyCustomer>(context, listen: false);
    return Column(
      children: <Widget>[
        _isExpanded
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                key: ValueKey(
                    DateTime.now().toString() + customer.number.toString()),
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
                        _listTileBuilder(customer),
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
                          height: customer.signature != null ? 200 : 50,
                          child: customer.signature != null
                              ? SvgPicture.string(customer.signature)
                              : Center(
                                  child: Text(
                                    "Nincs aláírása a kiválasztott vásárlónak",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
                    child: _listTileBuilder(customer),
                  ),
                ),
              ),
      ],
    );
  }
}
