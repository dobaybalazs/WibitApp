import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';

class BasicLifejacket with ChangeNotifier {
  final int id;
  final String size;

  BasicLifejacket({
    @required this.id,
    @required this.size,
  });
}

class BasicVests with ChangeNotifier {
  List<BasicLifejacket> _vests = [];

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
    DBHelper.insert('basic_vests', {
      'id': id,
      'size': size,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('basic_vests');
    _vests = dataList
        .map((e) => BasicLifejacket(id: e['id'], size: e['size']))
        .toList();
    notifyListeners();
  }

  void removeLifejacket(int id) {
    if (_vests.firstWhere((element) => element.id == id) != null) {
      _vests.removeWhere((element) => element.id == id);
    }
    notifyListeners();
    DBHelper.remove('basic_vests', id);
  }
}
