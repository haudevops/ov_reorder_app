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
      case ReOrderAbleWidget.routeName:
        return SlideLeftRoute(ReOrderAbleWidget(data: arg));
      case ReOrderAbleExportWidget.routeName:
        return SlideLeftRoute(ReOrderAbleExportWidget(data: arg));
      case TimeLineView.routeName:
        return SlideLeftRoute(TimeLineView(data: arg));
      default:
        throw ('this route name does not exist');
    }
  }
}
