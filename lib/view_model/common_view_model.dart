import 'package:flutter/material.dart';

class CommonViewModel extends ChangeNotifier{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _connected = false;
  bool get connnected => _connected;

  int _navigationIndex = 0;
  int get navigationIndex => _navigationIndex;

  PageController _pagecontroller = PageController();
  PageController get pagecontroller => _pagecontroller;
  setNavigationIndex(int index) {
    _navigationIndex = index;
    notifyListeners();
  }

  setLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  setInitial(int index) {
    _pagecontroller = PageController(initialPage: index);
    setNavigationIndex(index);
    notifyListeners();
  }

  itemTapped(int index) {
    setNavigationIndex(index);
    _pagecontroller.jumpToPage(index);
    notifyListeners();
  }
}