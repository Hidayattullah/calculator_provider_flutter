import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/calculator_model.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<CalculatorModel>(); // Mengambil model dari Provider

    return IconButton(
      icon: const Icon(Icons.brightness_6),
      onPressed: () {
        model.toggleTheme(); // Ubah tema
      },
      color: model.isDarkMode ? Colors.white : Colors.black, // Sesuaikan warna ikon
    );
  }
}
