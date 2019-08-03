class ThemeVariant {
  Variant variant;

  ThemeVariant({this.variant = Variant.light});

  factory ThemeVariant.fromIndex(int index) {
    switch (index) {
      case 1:
        return ThemeVariant(variant: Variant.dark);
      case 2:
        return ThemeVariant(variant: Variant.light);
      default:
        return ThemeVariant(variant: Variant.light);
    }
  }

  int get index {
    switch (variant) {
      case Variant.dark:
        return 1;
      case Variant.light:
        return 2;
      default:
        return 1;
    }
  }
}

enum Variant { dark, light }
