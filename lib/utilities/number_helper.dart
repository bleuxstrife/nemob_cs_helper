import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberHelper {
  static double doubleParse(String source) {
    source = (source ?? "");
    source = source.isEmpty ? "0" : source;
    source = source.replaceAll(",", "");

    return double.tryParse(source);
  }
}