import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _darkThemeEnabled = false;

  bool get darkThemeEnabled => _darkThemeEnabled;

  Future<void> changeTheme(bool darkTheme) async {
    // _darkThemeEnabled = !_darkThemeEnabled;
    _darkThemeEnabled = darkTheme;
    notifyListeners();
  }
}
