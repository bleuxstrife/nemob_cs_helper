import 'dart:async';

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nemob_cs_helper/application.dart';

class CsHelperDict {
  CsHelperDict({Locale locale}) : this.locale = locale ?? const Locale("en");

  final Locale locale;

  static CsHelperDict of(BuildContext context) {
    return Localizations.of<CsHelperDict>(context, CsHelperDict);
  }

  static Map<String, Map<String, Map<String, String>>> _localizedMaps = {
    "id": {
      "special_cars_type": {
        "all_car_type": "Semua Jenis Mobil",
        "wedding": "Pernikahan",
        "sport": "Sport"
      },
      
    },
    "en": {
      "special_cars_type": {"all_car_type": "All Car Type", "wedding": "Wedding", "sport": "Sport"},
      
    }
  };

  static Map<String, Map<String, List<String>>> _localizedArrays = {
    "id": {
      "weekdays": ['Ming', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'],
     
    },
    "en": {
      "weekdays": ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'],
    
    }
  };

//  'verify_code' => 'Kode Verifikasi'
//  -- untuk normal
//  'verify_code_short' => 'Kode Verif'
//  -- untuk yang singkat
//  'verify_code_info' => 'Pesan mengenai kode konfirmasi akan dikirimkan ke ponsel anda.'
//  -- untuk medium size info
//  'verify_code_label' => 'Kode Verifikasi : '
//  -- untuk label dengan :
//  'verify_code_msg' => 'Verifikasi kode bertujuan untuk menverifikasi nomor handphone yang anda masukkan, sehingga kami tahu bahwa itu adalah nomor anda pribadi. Caranya tinggal klik 'Verifikasi', dan kami akan mengirimkan kode ke Handphone anda dalam bentuk SMS, lalu masukkan kode tersebut ke dalam sistem'
//  -- untuk yang agak panjang infonya
//  'verify_code_title' => 'Konfirmasi nomor telepon'
//  -- untuk title page, usahakan pakai verify_code dulu (yang polos)
//  'err_verify_code_(terserah)' => 'Konfirmasi nomor telepon salah!'
//  -- untuk error, terserahnya bisa diisi huruf (empty / length) atau 1 2 3 jg gpp

  static Map<String, Map<String, String>> _localizedValues = {
    'id': {
      'quit_apps': 'Keluar Aplikasi',
      'quit_apps_msg': 'Anda Yakin Untuk Keluar dari Aplikasi?',
      'no': 'Tidak',
      'yes':'Ya',
      'gps':'GPS',
      'notification':'Notifikasi',
    },
    'en': {
      'quit_apps': 'Quit Application',
      'quit_apps_msg': 'Are You Sure To Leave Application?',
      'no': 'No',
      'yes':'Yes',
      'gps':'GPS',
      'notification':'Notification',
    },
  };

  String getString(String value) {
    Map<String, String> localizedValue =
        _localizedValues[locale.languageCode] ?? _localizedValues["en"];

    return localizedValue[value] ?? _localizedValues["en"][value] ?? "Raw $value";
  }

  Map<String, String> getMap(String value) {
    Map<String, Map<String, String>> localizedMaps =
        _localizedMaps[locale.languageCode] ?? _localizedMaps["en"];
    return localizedMaps["$value"] ?? ["Raw $value"];
  }

  List<String> getArray(String value) {
    Map<String, List<String>> localizedArrays =
        _localizedArrays[locale.languageCode] ?? _localizedArrays["en"];

    return localizedArrays[value] ?? ["Raw $value"];
  }

  DateFormat getDateFormat(String format) {
    return DateFormat(format, locale.languageCode ?? "en");
  }

  NumberFormat getNumberFormat(String format) {
    return NumberFormat(format, locale.languageCode ?? "en");
  }
}

class CsHelperLocalizationsDelegate extends LocalizationsDelegate<CsHelperDict> {
  final Locale overriddenLocale;

  const CsHelperLocalizationsDelegate({this.overriddenLocale});

  @override
  bool isSupported(Locale locale) =>
      application.supportedLanguagesCodes.contains(locale.languageCode);

  @override
  Future<CsHelperDict> load(Locale locale) {
    return SynchronousFuture<CsHelperDict>(CsHelperDict(locale: this.overriddenLocale ?? locale));
  }

  @override
  bool shouldReload(CsHelperLocalizationsDelegate old) => true;
}
