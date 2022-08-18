import 'package:flutter/material.dart';

class BorrowedVest extends StatefulWidget {
  final int id;

  BorrowedVest({@required this.id});
  @override
  State<BorrowedVest> createState() => _BorrowedVestState();
}

class _BorrowedVestState extends State<BorrowedVest> {
  Widget _listTileBuilder() {
    return ListTile(
      leading: Image.asset(
        'assets/images/lifejacket.jpg',
        fit: BoxFit.cover,
        height: 56,
      ),
      title: Text("Pistef József"),
      subtitle: Text(
        "55",
        style: TextStyle(fontSize: 15, color: Colors.black87),
      ),
      trailing: Text(
        '90:00',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
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
                                onPressed: () {},
                                icon: Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.pause),
                              ),
                              IconButton(
                                onPressed: () {},
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
