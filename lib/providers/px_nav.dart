import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class PxNav extends ChangeNotifier {
  final SidebarXController _xController = SidebarXController(
    selectedIndex: _index,
    extended: _extended,
  );

  SidebarXController get controller => _xController;

  static int _index = 0;
  int get index => _index;

  static bool _extended = false;
  bool get extended => _extended;

  void setIndex(int i) {
    _index = i;
    notifyListeners();
  }

  void navToIndex(int index) {
    setIndex(index);
    _xController.selectIndex(index);
  }

  void collapse() {
    _extended = false;
    notifyListeners();
    _xController.setExtended(extended);
  }

  void expandCollapse() {
    setExtended();
    _xController.setExtended(extended);
  }

  void setExtended() {
    _extended = !_extended;
    notifyListeners();
  }

  @override
  dispose() {
    _xController.dispose();
    super.dispose();
  }
}
