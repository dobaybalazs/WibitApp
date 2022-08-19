import 'package:flutter/material.dart';

class BorrowedLifeJacket with ChangeNotifier {
  final int id;
  final String name;
  final String size;
  int duration;
  bool isStopped;

  BorrowedLifeJacket({
    @required this.id,
    @required this.name,
    @required this.size,
    @required this.duration,
    this.isStopped = true,
  });

  void adjustDuration(int value) {
    duration = duration + value < 0 ? 0 : duration + value;
    notifyListeners();
  }

  void toggleIsStopped() {
    isStopped = !isStopped;
    notifyListeners();
  }
}

class BorrowedVests with ChangeNotifier {
  List<BorrowedLifeJacket> _items = [];

  List<BorrowedLifeJacket> get items {
    return [..._items];
  }

  void borrowVest(int id, String name, String size, int duration) {
    _items.add(
      BorrowedLifeJacket(id: id, name: name, size: size, duration: duration),
    );
    notifyListeners();
  }

  void removeVest(int id) {
    if (_items.firstWhere((element) => element.id == id) != null) {
      _items.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }
}
