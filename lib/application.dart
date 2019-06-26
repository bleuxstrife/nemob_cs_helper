import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/flavor.dart';

abstract class HomeInterface {}

class Application {
  static final Application _application = Application._internal();

  HomeInterface homeInterface;

  FlavorConfig flavor;

  factory Application() {
    return _application;
  }

  Application._internal();

  final Map<String, String> supportedLanguagesMap = {"en": "English", "id": "Bahasa"};

  final List<String> supportedLanguages = [
    "English",
    "Bahasa",
  ];

  final List<String> supportedLanguagesCodes = [
    "en",
    "id",
  ];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
