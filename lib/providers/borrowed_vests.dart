import 'package:flutter/material.dart';

class BorrowedLifeJacket {
  final int id;
  final String name;
  final String size;
  final int duration;

  BorrowedLifeJacket(
      {@required this.id,
      @required this.name,
      @required this.size,
      @required this.duration});
}

class BorrowedVests with ChangeNotifier {
  List<BorrowedLifeJacket> _items = [
    BorrowedLifeJacket(
        id: 1, name: 'Pistef József', size: 'Mini', duration: 90),
    BorrowedLifeJacket(id: 2, name: 'Lukapop Simon', size: 'XXL', duration: 60),
    BorrowedLifeJacket(id: 3, name: 'Nyas Gem', size: 'XL', duration: 45),
  ];

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
