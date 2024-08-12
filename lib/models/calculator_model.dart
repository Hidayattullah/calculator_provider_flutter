import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

import 'button_model.dart';
import 'display_model.dart';
import 'history_model.dart';
import 'theme_model.dart';


class CalculatorModel with ChangeNotifier {
  final DisplayModel _displayState = DisplayModel();
  final HistoryModel _historyManager = HistoryModel();
  final ThemeModel _themeManager = ThemeModel();
  final ButtonModel _buttonStateManager = ButtonModel();

  // Getter untuk tampilan layar
  String get display => _displayState.display;

  // Getter untuk history
  List<String> get history => _historyManager.history;

  // Getter untuk mengetahui mode saat ini
  bool get isDarkMode => _themeManager.isDarkMode;

  // Fungsi untuk menambahkan angka atau operator ke layar
  void addInput(String input) {
    _displayState.addInput(input);
    notifyListeners();
  }

  // Fungsi untuk menghitung hasil
  void calculate() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_displayState.display);
      ContextModel cm = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, cm);

      String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      _historyManager.addHistory('${_displayState.display} = $result at $timestamp');

      _displayState.setDisplay(result.toString());
    } catch (e) {
      _displayState.setDisplay('Error');
    }
    notifyListeners();
  }

  // Fungsi untuk menghapus semua input
  void clear() {
    _displayState.clear();
    notifyListeners();
  }

  // Fungsi untuk menghapus karakter terakhir (backspace)
  void delete() {
    _displayState.delete();
    notifyListeners();
  }

  // Fungsi untuk menghapus history
  void clearHistory() {
    _historyManager.clearHistory();
    notifyListeners();
  }

  // Fungsi untuk mengubah mode tema
  void toggleTheme() {
    _themeManager.toggleTheme();
    notifyListeners();
  }

  // Fungsi terkait hover dan tekan tombol
  void setHoverButton(String? button) {
    _buttonStateManager.setHoverButton(button);
    notifyListeners();
  }

  void setPressedButton(String? button) {
    _buttonStateManager.setPressedButton(button);
    notifyListeners();
  }

  bool isButtonHovered(String button) {
    return _buttonStateManager.isButtonHovered(button);
  }

  bool isButtonPressed(String button) {
    return _buttonStateManager.isButtonPressed(button);
  }
}
