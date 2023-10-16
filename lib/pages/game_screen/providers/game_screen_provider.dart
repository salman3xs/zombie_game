import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameScreenNotifier = ChangeNotifierProvider<GameScreenNotifier>((ref) {
  return GameScreenNotifier();
});

class GameScreenNotifier extends ChangeNotifier {
  int _points = 0;
  int get points => _points;
  set points(int points) {
    _points = points;
    notifyListeners();
  }

  void addPoint() {
    points += 1;
  }

  void resetPoint() {
    points = 0;
  }
}
