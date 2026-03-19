enum Flavor {
  prod,
  stage,
  dev;

  String get apiUrl {
    switch (this) {
      case Flavor.prod:
        return 'https://prod.api.com';
      case Flavor.stage:
        return 'https://stage.api.com';
      case Flavor.dev:
        return 'https://dev.api.com';
    }
  }
}

final class FlavorConfig {
  FlavorConfig({required this.flavor}) {
    if (_data != null) throw Exception();
    _initWith(flavor);
  }

  Flavor flavor;

  static FlavorsData? _data;

  void _initWith(Flavor flavor) {
    _data = FlavorsData(flavor: flavor);
  }

  static FlavorsData get data => _data ??= throw Exception();

  static String get apiUrl => data.apiUrl;

  static String get appName => data.appName;
}

class FlavorsData {
  FlavorsData({required this.flavor});
  final Flavor flavor;

  String get apiUrl => flavor.apiUrl;

  String get appName => flavor.name;
}
