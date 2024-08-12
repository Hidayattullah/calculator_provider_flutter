class ButtonModel {
  String? _hoveredButton;
  String? _pressedButton;

  // Setel tombol yang sedang di-hover
  void setHoverButton(String? button) {
    _hoveredButton = button;
  }

  // Setel tombol yang sedang ditekan
  void setPressedButton(String? button) {
    _pressedButton = button;
  }

  // Periksa apakah tombol sedang dihover
  bool isButtonHovered(String button) {
    return _hoveredButton == button;
  }

  // Periksa apakah tombol sedang ditekan
  bool isButtonPressed(String button) {
    return _pressedButton == button;
  }
}
