import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart'; // Digunakan untuk format timestamp

class CalculatorModel with ChangeNotifier {
  String _display = ''; // Menyimpan semua input operasi
  List<String> _history = []; // Menyimpan riwayat perhitungan

  // Getter untuk tampilan layar
  String get display => _display.isEmpty ? '0' : _display;

  // Getter untuk history
  List<String> get history => _history;

  // Fungsi untuk menambahkan angka atau operator ke layar
  void addInput(String input) {
    _display += input;
    notifyListeners(); // Memberitahukan perubahan state
  }

  // Fungsi untuk menghitung hasil
  void calculate() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_display); // Parse ekspresi matematika
      ContextModel cm = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, cm);

      String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      _history.add('$_display = $result at $timestamp'); // Simpan operasi dengan hasil dan timestamp

      _display = result.toString(); // Menampilkan hasil
    } catch (e) {
      _display = 'Error'; // Jika ada kesalahan dalam perhitungan
    }
    notifyListeners();
  }

  // Fungsi untuk menghapus semua input
  void clear() {
    _display = '';
    notifyListeners();
  }

  // Fungsi untuk menghapus karakter terakhir (backspace)
  void delete() {
    if (_display.isNotEmpty) {
      _display = _display.substring(0, _display.length - 1);
      notifyListeners();
    }
  }

  // Fungsi untuk menghapus history
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
