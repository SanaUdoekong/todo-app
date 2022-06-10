// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:flutter_todo/core/router_constants.dart';


import 'package:flutter_todo/views/home/home_view.dart' as view0;
import 'package:flutter_todo/views/completed/completed_view.dart' as view1;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => const view0.HomeView());
      case completedViewRoute:
        return MaterialPageRoute(builder: (_) => view1.CompletedView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}