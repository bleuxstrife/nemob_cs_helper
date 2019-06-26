enum Flavor {
  development,
  production
}

class FlavorConfig {
  final String endPoint;
  final String dynamicLink;
  final String midTransKey;
  final Flavor flavor;

  FlavorConfig(this.endPoint, this.dynamicLink, this.midTransKey, this.flavor);
}

FlavorConfig flavorDev = FlavorConfig("http://needmobildev.com", "link.nemob.id", "VT-client-j_y7RRFZJETHsqMe", Flavor.development);
FlavorConfig flavorProduction = FlavorConfig("https://nemob.id", "link.nemob.id", "VT-client-ZgRC-r-WntD2epbI", Flavor.production);