import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/basic_vests.dart';
import '../../providers/borrowed_vests.dart';
import '../../providers/daily_customers.dart';

class BorrowedVest extends StatefulWidget {
  @override
  State<BorrowedVest> createState() => _BorrowedVestState();
}

class _BorrowedVestState extends State<BorrowedVest> {
  Widget _listTileBuilder(BorrowedLifeJacket vest) {
    return ListTile(
      leading: Image.asset(
        'assets/images/lifejacket.jpg',
        fit: BoxFit.cover,
        height: 56,
      ),
      title: Text(vest.name),
      subtitle: Text(
        '${vest.id}',
        style: TextStyle(fontSize: 15, color: Colors.black87),
      ),
      trailing: Text(
        '${vest.duration.inMinutes < 10 ? '0${vest.duration.inMinutes}' : vest.duration.inMinutes}:${vest.duration.inSeconds % 60 < 10 ? '0${vest.duration.inSeconds % 60}' : vest.duration.inSeconds % 60}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    final basicVests = Provider.of<BasicVests>(context, listen: false);
    final borrowedVests = Provider.of<BorrowedVests>(context, listen: false);
    final vest = Provider.of<BorrowedLifeJacket>(context);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        basicVests.addNewLifejacket(vest.size, vest.id);
        Provider.of<DailyCustomers>(context, listen: false)
            .setExpDate(vest.arrivalTime);
        borrowedVests.removeVest(vest.id);
      },
      key: ValueKey(vest.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete_sweep,
          color: Colors.white,
          size: 35,
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: _expanded
            ? Card(
                elevation: 4,
                color: vest.duration.inSeconds == 0 ? Colors.red : Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Column(
                  children: [
                    _listTileBuilder(vest),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.black12,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              setState(() {
                                vest.adjustDuration(-5);
                              });
                            },
                            icon: Icon(Icons.remove_circle_outline),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                vest.adjustDuration(-1);
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                          vest.isStopped
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      vest.toggleIsStopped();
                                      vest.startTimer();
                                    });
                                  },
                                  icon: Icon(Icons.play_arrow),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      vest.toggleIsStopped();
                                      vest.stopTimer();
                                    });
                                  },
                                  icon: Icon(Icons.pause),
                                ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                vest.adjustDuration(1);
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                vest.adjustDuration(5);
                              });
                            },
                            icon: Icon(Icons.add_box_outlined),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Card(
                elevation: 4,
                color: vest.duration.inSeconds == 0 ? Colors.red : Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: _listTileBuilder(vest),
              ),
      ),
    );
  }
}
