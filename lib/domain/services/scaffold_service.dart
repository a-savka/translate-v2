import 'package:flutter/material.dart';

class ScaffoldService {
  GlobalKey<ScaffoldState>? _mainScaffoldKey;

  bool get hasScaffoldKey => _mainScaffoldKey != null;
  GlobalKey<ScaffoldState>? get mainScaffoldKey => _mainScaffoldKey;

  GlobalKey<ScaffoldState> makeScaffoldKey() {
    _mainScaffoldKey = GlobalKey<ScaffoldState>();
    return _mainScaffoldKey!;
  }

  void closeDrawer() {
    if (hasScaffoldKey &&
        mainScaffoldKey!.currentState != null &&
        mainScaffoldKey!.currentState!.isDrawerOpen) {
      mainScaffoldKey!.currentState!.closeDrawer();
    }
  }
}
