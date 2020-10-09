// GENERATED CODE - DO NOT MODIFY MANUALLY
// **************************************************************************
// Auto generated by https://github.com/fluttercandies/ff_annotation_route
// **************************************************************************

import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_study/moments/detail_model.dart';
import 'route_new.dart';
import 'router_arg.dart';
import 'router_not_arg.dart';

RouteResult getRouteResult({String name, Map<String, dynamic> arguments}) {
  arguments = arguments ?? const <String, dynamic>{};
  switch (name) {
    case '/routeNew':
      return RouteResult(
        name: name,
        widget: RouteNew(),
        showStatusBar: false,
      );
    case '/routerArg':
      return RouteResult(
        name: name,
        widget: RouterArg(
          key: arguments['key'] as Key,
          value: arguments['value'] as int,
          text: arguments['text'] as String,
          avsModel: arguments['avsModel'] as Avs,
        ),
        routeName: 'RouterArg',
      );
    case '/routerNotArg':
      return RouteResult(
        name: name,
        widget: RouterNotArg(),
        routeName: 'RouterNotArg',
      );
    default:
      return const RouteResult(name: 'flutterCandies://notfound');
  }
}

class RouteResult {
  const RouteResult({
    @required this.name,
    this.widget,
    this.showStatusBar = true,
    this.routeName = '',
    this.pageRouteType,
    this.description = '',
    this.exts,
  });

  /// The name of the route (e.g., "/settings").
  ///
  /// If null, the route is anonymous.
  final String name;

  /// The Widget return base on route
  final Widget widget;

  /// Whether show this route with status bar.
  final bool showStatusBar;

  /// The route name to track page
  final String routeName;

  /// The type of page route
  final PageRouteType pageRouteType;

  /// The description of route
  final String description;

  /// The extend arguments
  final Map<String, dynamic> exts;
}
