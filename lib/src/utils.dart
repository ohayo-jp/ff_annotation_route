Type typeOf<T>() => T;

const String fileHeader = '''// GENERATED CODE - DO NOT MODIFY MANUALLY
// **************************************************************************
// Auto generated by https://github.com/fluttercandies/ff_annotation_route
// **************************************************************************
// ignore_for_file: argument_type_not_assignable\n''';

const String rootFile = """

RouteResult getRouteResult({String name, Map<String, dynamic> arguments}) {
  arguments = arguments ?? const <String, dynamic>{};
  switch (name) {
{0}   default:
      return const RouteResult(name:'flutterCandies://notfound');
  }
}

class RouteResult {
  const RouteResult({
    @required
    this.name,
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
  final Map<String,dynamic> exts;
}

enum PageRouteType { material, cupertino, transparent, }
""";

String routeHelper(
  String name,
  bool routeSettingsNoArguments,
  bool routeSettingsNoIsInitialRoute,
) =>
    """
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '${name}_route.dart';

class FFNavigatorObserver extends NavigatorObserver {
  FFNavigatorObserver({this.routeChange});

  final RouteChange routeChange;

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    _didRouteChange(previousRoute, route);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    _didRouteChange(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    _didRouteChange(previousRoute, route);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _didRouteChange(newRoute, oldRoute);
  }

  void _didRouteChange(Route<dynamic> newRoute, Route<dynamic> oldRoute) {
    // oldRoute may be null when route first time enter.
    routeChange?.call(newRoute,oldRoute);
  }
}

typedef RouteChange = void Function(Route<dynamic> newRoute, Route<dynamic> oldRoute);

class FFTransparentPageRoute<T> extends PageRouteBuilder<T> {
  FFTransparentPageRoute({
    RouteSettings settings,
    @required RoutePageBuilder pageBuilder,
    RouteTransitionsBuilder transitionsBuilder = _defaultTransitionsBuilder,
    Duration transitionDuration = const Duration(milliseconds: 150),
    bool barrierDismissible = false,
    Color barrierColor,
    String barrierLabel,
    bool maintainState = true,
  }) : assert(pageBuilder != null),
       assert(transitionsBuilder != null),
       assert(barrierDismissible != null),
       assert(maintainState != null),
       super(
         settings: settings,
         opaque: false,
         pageBuilder: pageBuilder,
         transitionsBuilder: transitionsBuilder,
         transitionDuration: transitionDuration,
         barrierDismissible: barrierDismissible,
         barrierColor: barrierColor,
         barrierLabel: barrierLabel,
         maintainState: maintainState,
       );
}

Widget _defaultTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

Route<dynamic> onGenerateRouteHelper(
  RouteSettings settings, {
  Widget notFoundFallback,
  ${routeSettingsNoArguments ? '@required' : ''}
  Object arguments,
  WidgetBuilder builder,  
}) {
  ${routeSettingsNoArguments ? '' : 'arguments??=settings.arguments;'}
  
  final RouteResult routeResult = getRouteResult(
    name: settings.name,
    arguments: arguments as Map<String, dynamic>,
  );
  if (routeResult.showStatusBar != null || routeResult.routeName != null) {
    settings = FFRouteSettings(
      name: settings.name,
      ${routeSettingsNoIsInitialRoute ? '' : 'isInitialRoute:settings.isInitialRoute,'}     
      routeName: routeResult.routeName,
      ${routeSettingsNoArguments ? '' : 'arguments: arguments as Map<String, dynamic>,'}
      showStatusBar: routeResult.showStatusBar,
    );
  }
  Widget page = routeResult.widget ?? notFoundFallback;
  if (page == null) {
    throw Exception('''Route "\${settings.name}" returned null. Route Widget must never return null, 
          maybe the reason is that route name did not match with right path.
          You can use parameter[notFoundFallback] to avoid this ugly error.''',);
  }

  if (arguments is Map<String, dynamic>) {
    final RouteBuilder builder = arguments['routeBuilder'] as RouteBuilder;
    if (builder != null) {
      return builder(page);
    }
  }

  if (builder != null) {
    page = builder(page, routeResult);
  } 

  switch (routeResult.pageRouteType) {
    case PageRouteType.material:
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext _) => page,
      );
    case PageRouteType.cupertino:
      return CupertinoPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext _) => page,
      );
    case PageRouteType.transparent:
      return FFTransparentPageRoute<dynamic>(
        settings: settings,
        pageBuilder: (
          BuildContext _,
          Animation<double> __,
          Animation<double> ___,
        ) =>
            page,
      );
    default:
      return kIsWeb || !Platform.isIOS
          ? MaterialPageRoute<dynamic>(
              settings: settings,
              builder: (BuildContext _) => page,
            )
          : CupertinoPageRoute<dynamic>(
              settings: settings,
              builder: (BuildContext _) => page,
            );
  }
}

typedef RouteBuilder = PageRoute<dynamic> Function(Widget page);

class FFRouteSettings extends RouteSettings {
  const FFRouteSettings({
    this.routeName,
    this.showStatusBar,
    String name,
    ${routeSettingsNoArguments ? '' : 'Object arguments,'}
    ${routeSettingsNoIsInitialRoute ? '' : 'bool isInitialRoute = false,'}   
  }) : super(
          name: name,
          ${routeSettingsNoIsInitialRoute ? '' : 'isInitialRoute:isInitialRoute,'}  
          ${routeSettingsNoArguments ? '' : 'arguments:arguments,'}
        );
  
  final String routeName;
  final bool showStatusBar;
}

/// Signature for a function that creates a widget, e.g.
typedef WidgetBuilder = Widget Function(Widget child, RouteResult routeResult);
""";
