class ThemeVariant {
  _Variant variant;

  ThemeVariant({this.variant = _Variant.light});

  factory ThemeVariant.fromIndex(int index) {
    switch (index) {
      case 1:
        return ThemeVariant(variant: _Variant.dark);
      case 2:
        return ThemeVariant(variant: _Variant.light);
      default:
        return ThemeVariant(variant: _Variant.light);
    }
  }

  int get index {
    switch (variant) {
      case _Variant.dark:
        return 1;
      case _Variant.light:
        return 2;
      default:
        return 1;
    }
  }
}

enum _Variant { dark, light }
