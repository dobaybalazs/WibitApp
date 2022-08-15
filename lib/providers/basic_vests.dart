import 'package:flutter/material.dart';

class BasicLifejacket with ChangeNotifier {
  final int id;
  final String size;

  BasicLifejacket({
    @required this.id,
    @required this.size,
  });
}

class BasicVests with ChangeNotifier {
  List<BasicLifejacket> _vests = [
    BasicLifejacket(id: 156, size: 'Mini'),
    BasicLifejacket(id: 132, size: 'XL'),
  ];

  List<BasicLifejacket> get vests {
    return [..._vests];
  }

  int get itemCount {
    return _vests.length;
  }

  void addNewLifejacket(String size, int id) {
    if (!_vests.any(((element) => element.id == id))) {
      _vests.add(BasicLifejacket(id: id, size: size));
    }

    notifyListeners();
  }

  void removeLifejacket(int id) {
    if (_vests.firstWhere((element) => element.id == id) != null) {
      _vests.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }
}
