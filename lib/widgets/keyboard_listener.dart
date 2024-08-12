import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/models/calculator_model.dart';

class KeyboardListenerWidget extends StatelessWidget {
  final Widget child;

  KeyboardListenerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<CalculatorModel>();

    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final key = event.character ?? '';
          if (buttons.contains(key)) {
            onButtonPressed(model, key);
          } else if (event.logicalKey == LogicalKeyboardKey.enter) {
            model.calculate();
          } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
            model.delete();
          }
        }
        return KeyEventResult.handled;
      },
      child: child,
    );
  }

  // Daftar tombol pada kalkulator
  final List<String> buttons = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    'C', '0', '=', '+',
    '<-', // Tombol Backspace
  ];

  void onButtonPressed(CalculatorModel model, String buttonText) {
    if (buttonText == 'C') {
      model.clear();
    } else if (buttonText == '=') {
      model.calculate();
    } else if (buttonText == '<-') {
      model.delete(); // Menghapus karakter terakhir
    } else {
      model.addInput(buttonText); // Menambahkan input
    }
  }
}
