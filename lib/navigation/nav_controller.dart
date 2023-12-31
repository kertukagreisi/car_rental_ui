import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/page/bookings_overview/bookings_overview_page.dart';
import 'package:car_rental_ui/page/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../page/book/book_page.dart';
import '../page/home/home_page.dart';
import '../page/login/login_page.dart';
import '../page/page_not_found/page_not_found.dart';
import '../widgets/car_rental_scaffold.dart';
import 'nav_route.dart';

class NavController {
  late final GoRouter _router = GoRouter(debugLogDiagnostics: true, initialLocation: NavRoute.home.path, errorPageBuilder: _pageBuilder, routes: [
    ShellRoute(
      builder: (_, __, child) => CarRentalScaffold(body: child),
      routes: [
        GoRoute(
          path: NavRoute.home.path,
          name: NavRoute.home.name,
          pageBuilder: _pageBuilder,
        ),
        GoRoute(
          path: NavRoute.book.path,
          name: NavRoute.book.name,
          pageBuilder: _pageBuilder,
        ),
        GoRoute(
          path: NavRoute.bookingsOverview.path,
          name: NavRoute.bookingsOverview.name,
          pageBuilder: _pageBuilder,
        ),
        GoRoute(
          path: NavRoute.user.path,
          name: NavRoute.user.name,
          pageBuilder: _pageBuilder,
        ),
        GoRoute(
          path: NavRoute.login.path,
          name: NavRoute.login.name,
          pageBuilder: _pageBuilder,
        ),
        GoRoute(
          path: NavRoute.pageNotFound.path,
          name: NavRoute.pageNotFound.name,
          pageBuilder: _pageBuilder,
        ),
      ],
    ),
  ]);

  GoRouter get router => _router;

  Page<void> _pageBuilder(BuildContext context, GoRouterState state) => NoTransitionPage<void>(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: _getPageByName(state.name ?? NavRoute.pageNotFound.name, state),
      );

  Widget _getPageByName(String pageName, GoRouterState state) {
    var navRoute = NavRoute.values.byName(pageName);
    switch (navRoute) {
      case NavRoute.home:
        return const HomePage();
      case NavRoute.book:
        final args = state.uri.queryParameters;
        final extra = state.extra;
        return BookPage(args: args, carFromExtraParameters: extra as Car?);
      case NavRoute.user:
        return const UserPage();
      case NavRoute.bookingsOverview:
        return const BookingsOverviewPage();
      case NavRoute.login:
        final args = state.uri.queryParameters;
        return LoginPage(args: args);
      default:
        return const PageNotFound();
    }
  }
}
