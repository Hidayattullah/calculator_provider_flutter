import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/calculator_model.dart';

class HistoryDrawer extends StatelessWidget {
  const HistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<CalculatorModel>(); // Mengambil model dari Provider

    return Drawer(
      child: Container(
        color: model.isDarkMode ? Colors.black : Colors.white, // Warna drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: model.isDarkMode ? Colors.grey[800] : Colors.blueAccent, // Warna header drawer
              ),
              child: Text(
                'History',
                style: TextStyle(
                  color: model.isDarkMode ? Colors.white : Colors.white, // Warna teks header drawer
                  fontSize: 24,
                ),
              ),
            ),
            ...model.history.map((entry) => ListTile(
              title: Text(
                entry,
                style: TextStyle(color: model.isDarkMode ? Colors.white : Colors.black), // Warna teks entry
              ),
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
    );
  }
}
