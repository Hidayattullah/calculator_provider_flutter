class ThemeModel {
  bool _isDarkMode = false; // State untuk mode gelap/terang

  // Getter untuk mengetahui mode saat ini
  bool get isDarkMode => _isDarkMode;

  // Fungsi untuk mengubah mode tema
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
  }
}
