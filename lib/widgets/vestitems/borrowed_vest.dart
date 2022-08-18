import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/basic_vests.dart';
import '../../providers/borrowed_vests.dart';

class BorrowedVest extends StatefulWidget {
  final int id;
  final String name;
  final String size;
  final int duration;

  BorrowedVest({
    @required this.id,
    @required this.name,
    @required this.size,
    @required this.duration,
  });
  @override
  State<BorrowedVest> createState() => _BorrowedVestState();
}

class _BorrowedVestState extends State<BorrowedVest> {
  int _timer = 0;
  Color _background = Colors.white;
  @override
  void initState() {
    _timer = widget.duration;
    super.initState();
  }

  Widget _listTileBuilder() {
    return ListTile(
      leading: Image.asset(
        'assets/images/lifejacket.jpg',
        fit: BoxFit.cover,
        height: 56,
      ),
      title: Text(widget.name),
      subtitle: Text(
        '${widget.id}',
        style: TextStyle(fontSize: 15, color: Colors.black87),
      ),
      trailing: Text(
        '${_timer}:00',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    final basicVests = Provider.of<BasicVests>(context, listen: false);
    final borrowedVests = Provider.of<BorrowedVests>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        basicVests.addNewLifejacket(widget.size, widget.id);
        borrowedVests.removeVest(widget.id);
      },
      key: ValueKey(widget.id),
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
                        _listTileBuilder(),
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
                                    _timer = (_timer - 5 < 0) ? 0 : _timer - 5;
                                    if (_timer == 0) {
                                      _background = Colors.red;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.pause),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _timer += 5;
                                    if (_timer != 0) {
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
                    child: _listTileBuilder(),
                  ),
          )
        ],
      ),
    );
  }
}
