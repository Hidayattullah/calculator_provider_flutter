class HistoryModel {
  final List<String> _history = []; // Menyimpan riwayat perhitungan

  // Getter untuk history
  List<String> get history => _history;

  // Fungsi untuk menambahkan riwayat perhitungan
  void addHistory(String record) {
    _history.add(record);
  }

  // Fungsi untuk menghapus history
  void clearHistory() {
    _history.clear();
  }
}
