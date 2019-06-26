import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/utilities/slide_left_route.dart';


class Routing {
  static Future<T> pushReplacement<T extends Object>(BuildContext context, Widget widget) async {
    var result = await Navigator.pushReplacement(
      context,
      SlideLeftRoute(widget: widget, settings: RouteSettings(name: widget.runtimeType.toString())),
    );
    return result;
  }

  static Future<T> push<T extends Object>(BuildContext context, Widget widget) async {
    var result = await Navigator.push(
      context,
      SlideLeftRoute(widget: widget, settings: RouteSettings(name: widget.runtimeType.toString())),
    );
    return result;
  }

  static Future<T> pushAndRemoveUntil<T extends Object>(BuildContext context, Widget widget, RoutePredicate predicate) async {
    print('push and remove until ${widget.runtimeType.toString()} : ${predicate}');
    var result = await Navigator.pushAndRemoveUntil(context,
        SlideLeftRoute(widget: widget, settings: RouteSettings(name: widget.runtimeType.toString())), predicate);
    return result;
  }
}
