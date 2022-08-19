import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/basic_vests.dart';
import '../../providers/borrowed_vests.dart';

class BorrowedVest extends StatefulWidget {
  @override
  State<BorrowedVest> createState() => _BorrowedVestState();
}

class _BorrowedVestState extends State<BorrowedVest> {
  Color _background = Colors.white;

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
        '${vest.duration}:00',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    final basicVests = Provider.of<BasicVests>(context, listen: false);
    final borrowedVests = Provider.of<BorrowedVests>(context, listen: false);
    final vest = Provider.of<BorrowedLifeJacket>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        basicVests.addNewLifejacket(vest.size, vest.id);
        borrowedVests.removeVest(vest.id);
      },
      key: ValueKey(vest.id),
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
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: _expanded
                ? Card(
                    elevation: 4,
                    color: _background,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                                    if (vest.duration == 0) {
                                      _background = Colors.red;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    vest.toggleIsStopped();
                                  });
                                },
                                icon: vest.isStopped
                                    ? Icon(Icons.pause)
                                    : Icon(Icons.play_arrow),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    vest.adjustDuration(5);
                                    if (vest.duration != 0) {
                                      _background = Colors.white;
                                    }
                                  });
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Card(
                    elevation: 4,
                    color: _background,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: _listTileBuilder(vest),
                  ),
          )
        ],
      ),
    );
  }
}
