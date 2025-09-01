/// Created this extension as it is much easier and quicker for implementation
/// Code credits => Kluivert
library;


extension ImageFormat on String {
  String get png {
    return 'assets/images/$this.png';
  }

  String get svg {
    return 'assets/icons/$this.svg';
  }

  String get json {
    return 'assets/json/$this.json';
  }

  String get gif{
    return 'assets/gifs/$this.gif';
  }
}
