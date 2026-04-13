import 'package:flutter/material.dart';

class LoadingViewModel extends ChangeNotifier {
  int _progress = 0;
  int get progress => _progress;

  bool _isFinished = false;
  bool get isFinished => _isFinished;

  void startLoading() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 25));
      _progress = i;
      notifyListeners();
    }
    _isFinished = true;
    notifyListeners();
  }
}
