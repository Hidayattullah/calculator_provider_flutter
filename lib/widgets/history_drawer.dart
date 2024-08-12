import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/calculator_model.dart';

class HistoryDrawer extends StatelessWidget {
  const HistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<CalculatorModel>(); // Mengambil model dari Provider

    return Drawer(
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
    );
  }
}
