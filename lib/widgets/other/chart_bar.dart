import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String name;
  final int quant;
  final int totalVestNum;

  ChartBar({@required this.name, @required this.quant,@required this.totalVestNum});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) => Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: FittedBox(
                  child: Text(name),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: constraints.maxHeight * 0.6,
                  width: 10,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      FractionallySizedBox(
                        heightFactor: 1 - (quant / totalVestNum),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: BorderDirectional(
                              start: BorderSide(
                                width: 1.0,
                                color: Colors.black38,
                              ),
                              end: BorderSide(
                                width: 1.0,
                                color: Colors.black38,
                              ),
                              top: BorderSide(
                                width: 1.0,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: FittedBox(
                  child: Text('$quant'),
                ),
              )
            ],
          )),
    );
  }
}
