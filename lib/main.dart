import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/calculator_model.dart';
import 'widgets/calculator_screen.dart'; // Akan kita buat di langkah berikutnya

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}
