import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'nav_route.dart';

extension NavControllerHelper on BuildContext {
  String get currentRoute => GoRouterState.of(this).fullPath!;

  Object? get extra => GoRouterState.of(this).extra;

  Map<String, String> get currentRouteParams => GoRouterState.of(this).pathParameters;

  Map<String, String> get currentRouteQueryParams => GoRouterState.of(this).uri.queryParameters;

  void goNamedRoute(
    NavRoute route, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      GoRouter.of(this).goNamed(
        route.name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  /// Navigate to a named route onto the page stack.
  void pushNamedRoute(
    NavRoute route, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      GoRouter.of(this).pushNamed(
        route.name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  void replaceNamedRoute(
    NavRoute route, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      GoRouter.of(this).pushReplacementNamed(
        route.name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  String getAppBarTitle() {
    var list = NavRoute.values.where((element) => element.path == currentRoute).toList();
    var navRoute = list.isNotEmpty ? list[0] : 'default';
    switch (navRoute) {
      case NavRoute.home:
        return 'Home';
      case NavRoute.rent:
        return 'Rent';
      case NavRoute.carDetails:
        return 'Car Details';
      case NavRoute.adminUsers:
        return 'Users Overview';
      case NavRoute.adminCars:
        return 'Cars Overview';
      case NavRoute.adminBookings:
        return 'Bookings Overview';
      case NavRoute.login:
        return 'Login';
      case NavRoute.pageNotFound:
        return 'Page Not Found';
      default:
        return 'Home';
    }
  }

  Future<void> navigateToPreviousLevel() async {
    var list = NavRoute.values.where((element) => element.path == currentRoute).toList();
    var navRoute = list.isNotEmpty ? list[0] : 'default';

    if (navRoute == NavRoute.rent) {
      goNamedRoute(NavRoute.carDetails, queryParams: currentRouteQueryParams, extra: extra);
    } else {
      goNamedRoute(NavRoute.home);
    }
  }
}
