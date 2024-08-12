class DisplayModel {
  String _display = ''; // Menyimpan semua input operasi

  // Getter untuk tampilan layar
  String get display => _display.isEmpty ? '0' : _display;

  // Fungsi untuk menambahkan angka atau operator ke layar
  void addInput(String input) {
    _display += input;
  }

  // Fungsi untuk mengatur tampilan layar
  void setDisplay(String display) {
    _display = display;
  }

  // Fungsi untuk menghapus semua input
  void clear() {
    _display = '';
  }

  // Fungsi untuk menghapus karakter terakhir (backspace)
  void delete() {
    if (_display.isNotEmpty) {
      _display = _display.substring(0, _display.length - 1);
    }
  }
}
