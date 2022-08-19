import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String name;
  final int quant;
  final int totalVestNum;

  ChartBar(
      {@required this.name, @required this.quant, @required this.totalVestNum});

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
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.black87),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FractionallySizedBox(
                          heightFactor: 1 -
                              (totalVestNum == 0
                                  ? 0.0
                                  : (quant / totalVestNum)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
