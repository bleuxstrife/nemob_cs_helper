import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/utilities/localization.dart';
import 'package:nemob_cs_helper/utilities/view.dart';


abstract class Presenter {
  final View _view;
  CsHelperDict _dict;
  BuildContext _context;

  View get view => _view;
  CsHelperDict get dict => _dict;
  BuildContext get context => _context;

  Presenter(this._context, this._view) {
    _dict = CsHelperDict.of(_context);
    init();
  }

  void init();
}