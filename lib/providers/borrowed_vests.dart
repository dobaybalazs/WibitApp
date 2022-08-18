import 'package:flutter/material.dart';

class BorrowedLifeJacket with ChangeNotifier {
  final int id;
  final String name;
  final String size;
  int duration;

  BorrowedLifeJacket({
    @required this.id,
    @required this.name,
    @required this.size,
    @required this.duration,
  });

  void adjustDuration(int value) {
    duration = duration + value < 0 ? 0 : duration + value;
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
