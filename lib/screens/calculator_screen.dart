import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/dark_mode_switch.dart';
import '/widgets/keyboard_listener.dart';
import '/widgets/history_drawer.dart';
import '/models/calculator_model.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<CalculatorModel>(); // Mengambil model dari Provider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: model.isDarkMode ? Colors.black : Colors.blueAccent, // Warna AppBar sesuai mode
        title: Text(
          'Kalkulator Responsif',
          style: TextStyle(
            color: model.isDarkMode ? Colors.white : Colors.black, // Warna teks AppBar sesuai mode
          ),
        ),
        actions: [
          DarkModeSwitch(), // Menggunakan widget Dark Mode Switch
        ],
      ),
      drawer: const HistoryDrawer(), // Menggunakan widget History Drawer
      body: KeyboardListenerWidget(
        child: Container(
          color: model.isDarkMode ? Colors.black : Colors.white, // Mengatur warna background berdasarkan mode
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    model.display, // Menampilkan angka di layar
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: model.isDarkMode ? Colors.white : Colors.black, // Warna teks berdasarkan mode
                    ),
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
                    Color? buttonColor;
                    Color textColor = model.isDarkMode ? Colors.white : Colors.white;

                    // Mengatur warna tombol berdasarkan jenisnya
                    if (buttonText == 'C') {
                      buttonColor = Colors.red; // Tombol 'C' berwarna merah
                    } else if (['+', '-', '*', '/'].contains(buttonText)) {
                      buttonColor = Colors.green; // Tombol operasi berwarna hijau
                    } else {
                      buttonColor = model.isDarkMode ? Colors.grey[800] : Colors.blueAccent; // Tombol lainnya
                    }

                    return MouseRegion(
                      onEnter: (_) => model.setHoverButton(buttonText), // Setel tombol yang sedang dihover
                      onExit: (_) => model.setHoverButton(null), // Hapus tombol yang sedang dihover
                      child: GestureDetector(
                        onTapDown: (_) => model.setPressedButton(buttonText), // Setel tombol yang ditekan
                        onTapUp: (_) => model.setPressedButton(null), // Hapus setelan tombol yang ditekan
                        onTapCancel: () => model.setPressedButton(null), // Mengatasi jika tap dibatalkan
                        onTap: () => onButtonPressed(model, buttonText), // Logika saat tombol ditekan
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100), // Efek animasi
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: model.isDarkMode && model.isButtonPressed(buttonText)
                                ? buttonColor?.withOpacity(0.5) // Efek klik dalam mode gelap
                                : model.isDarkMode && model.isButtonHovered(buttonText)
                                    ? buttonColor?.withOpacity(0.7) // Efek hover dalam mode gelap
                                    : model.isButtonPressed(buttonText)
                                        ? buttonColor?.withOpacity(0.7) // Efek klik dalam mode terang
                                        : model.isButtonHovered(buttonText)
                                            ? buttonColor?.withOpacity(0.85) // Efek hover dalam mode terang
                                            : buttonColor, // Warna default
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                fontSize: 24,
                                color: textColor, // Warna teks
                              ),
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
        ),
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
