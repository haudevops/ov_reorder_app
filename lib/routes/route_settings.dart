import 'package:flutter/material.dart';
import 'package:reorder_app/page/page.dart';

import 'screen_arguments.dart';
import 'slide_left_route.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    late ScreenArguments arg;
    final Object? arguments = settings.arguments;
    if (arguments != null) {
      arg = arguments as ScreenArguments;
    }
    switch (settings.name) {
      case HomeView.routeName:
        return SlideLeftRoute(HomeView());
      case ImportGoodView.routeName:
        return SlideLeftRoute(ImportGoodView());
      case ExportGoodView.routeName:
        return SlideLeftRoute(ExportGoodView());
      default:
        throw ('this route name does not exist');
    }
  }
}
