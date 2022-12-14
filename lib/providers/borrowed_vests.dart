import 'dart:async';
import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';

class BorrowedLifeJacket with ChangeNotifier {
  final int id;
  final String name;
  final String size;
  final String arrivalTime;
  Timer countDownTimer;
  Duration duration;
  bool isStopped;
  bool isOver;

  BorrowedLifeJacket({
    @required this.id,
    @required this.name,
    @required this.size,
    @required this.arrivalTime,
    @required this.duration,
    this.isStopped = true,
    this.isOver = false,
  });

  void adjustDuration(int value) {
    duration = Duration(
        seconds: duration.inSeconds + value * 60 < 0
            ? 0
            : duration.inSeconds + value * 60);
    if (duration.inSeconds <= 0) {
      setIsOver(true);
    } else {
      setIsOver(false);
    }
    DBHelper.updateIntData(
        'borrowed_vests', 'duration', duration.inSeconds, id);
    notifyListeners();
  }

  void startTimer() {
    isStopped = false;
    countDownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        countDownTimer.cancel();
        toggleIsStopped();
        setIsOver(true);
      } else {
        duration = Duration(seconds: seconds);
        DBHelper.updateIntData(
            'borrowed_vests', 'duration', duration.inSeconds, id);
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    countDownTimer.cancel();
    isStopped = true;
    notifyListeners();
  }

  void toggleIsStopped() {
    isStopped = !isStopped;
    notifyListeners();
  }

  void setIsOver(bool newValue) {
    isOver = newValue;
    notifyListeners();
  }
}

class BorrowedVests with ChangeNotifier {
  List<BorrowedLifeJacket> _items = [];

  BorrowedVests(this._items);

  List<BorrowedLifeJacket> get items {
    _items.sort(
      (a, b) => a.duration.compareTo(b.duration),
    );
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  bool containsId(int id) {
    return _items.any((element) => element.id == id);
  }

  Duration getDuration(int id) {
    return _items.firstWhere((element) => element.id == id).duration;
  }

  void startAll() {
    items.forEach((element) {
      if (element.isStopped) {
        element.startTimer();
      }
    });
  }

  void stopAll() {
    items.forEach((element) {
      element.stopTimer();
    });
  }

  void borrowVest(
      int id, String name, String arrivalTime, String size, Duration duration) {
    _items.add(
      BorrowedLifeJacket(
          id: id,
          name: name,
          arrivalTime: arrivalTime,
          size: size,
          duration: duration),
    );
    notifyListeners();
    DBHelper.insert('borrowed_vests', {
      'id': id,
      'name': name,
      'duration': duration.inSeconds,
      'arrivalTime': arrivalTime,
      'size': size
    });
  }

  Future<void> fetchAndSetBorrowedVests() async {
    final dataList = await DBHelper.getData('borrowed_vests');
    _items = dataList
        .map(
          (e) => BorrowedLifeJacket(
            id: e['id'],
            name: e['name'],
            duration: Duration(seconds: e['duration']),
            arrivalTime: e['arrivalTime'],
            size: e['size'],
          ),
        )
        .toList();
    notifyListeners();
  }

  void removeVest(int id) {
    if (_items.any((element) => element.id == id)) {
      _items.removeWhere((element) => element.id == id);
    }
    notifyListeners();
    DBHelper.remove('borrowed_vests', id);
  }

  void deleteAllVests() {
    _items.clear();
    notifyListeners();
    DBHelper.removeAll('borrowed_vests');
  }
}
