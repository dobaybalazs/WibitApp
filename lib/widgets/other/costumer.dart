import 'package:flutter/material.dart';

class Costumer extends StatefulWidget {
  @override
  State<Costumer> createState() => _CostumerState();
}

class _CostumerState extends State<Costumer> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return _isExpanded
        ? Container(
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
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.account_circle_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 38,
                      ),
                      title: Text('Pistef József'),
                      subtitle: Text('55'),
                      trailing: Text('11:00 - 12:00'),
                    ),
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
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 38,
                  ),
                  title: Text('Pistef József'),
                  subtitle: Text('55'),
                  trailing: Text('11:00 - 12:00'),
                ),
              ),
            ),
          );
  }
}
