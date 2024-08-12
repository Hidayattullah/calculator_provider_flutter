import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/calculator_model.dart';

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<CalculatorModel>(); // Mengambil model dari Provider

    return Switch(
      value: model.isDarkMode,
      onChanged: (value) {
        model.toggleTheme(); // Ubah tema
      },
    );
  }
}
