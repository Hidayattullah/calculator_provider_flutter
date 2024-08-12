import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/calculator_model.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<CalculatorModel>(); // Mengambil model dari Provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Responsif'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ...model.history.map((entry) => ListTile(
              title: Text(entry),
            )),
            if (model.history.isNotEmpty)
              ListTile(
                title: const Text(
                  'Clear History',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  model.clearHistory(); // Bersihkan history
                  Navigator.of(context).pop(); // Tutup drawer setelah menghapus
                },
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                model.display, // Menampilkan angka di layar
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2, // Memperbesar bagian tombol
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Jumlah kolom
                childAspectRatio: 1.5,
              ),
              itemCount: buttons.length, // Total tombol
              itemBuilder: (context, index) {
                String buttonText = buttons[index];
                return GestureDetector(
                  onTap: () => onButtonPressed(model, buttonText),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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

  CalculatorScreen({super.key});

  // Fungsi untuk mengatur apa yang terjadi saat tombol ditekan
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
