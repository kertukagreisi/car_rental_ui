import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/page/admin-pages/admin-bookings/admin_bookings_page.dart';
import 'package:car_rental_ui/page/admin-pages/admin-cars/admin_cars_page.dart';
import 'package:car_rental_ui/page/admin-pages/admin-users/admin_users_page.dart';
import 'package:car_rental_ui/page/bookings_overview/bookings_overview_page.dart';
import 'package:car_rental_ui/page/profile/profile_page.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../page/car-details/car_details_page.dart';
import '../page/home/home_page.dart';
import '../page/login/login_page.dart';
import '../page/page_not_found/page_not_found.dart';
import '../page/rent/rent_page.dart';
import '../shared/auth_service.dart';
import '../shared/helpers.dart';
import '../shared/locator.dart';
import '../widgets/car_rental_scaffold.dart';
import 'nav_route.dart';

class NavController {
  late final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: NavRoute.home.path,
      errorPageBuilder: _pageBuilder,
      routes: [
        ShellRoute(
          builder: (_, __, child) => CarRentalScaffold(body: child),
          routes: [
            // no auth routes
            GoRoute(
              path: NavRoute.home.path,
              name: NavRoute.home.name,
              pageBuilder: _pageBuilder,
            ),
            GoRoute(
              path: NavRoute.carDetails.path,
              name: NavRoute.carDetails.name,
              pageBuilder: _pageBuilder,
            ),

            // user routes
            GoRoute(
              path: NavRoute.rent.path,
              name: NavRoute.rent.name,
              pageBuilder: _pageBuilder,
            ),
            GoRoute(
              path: NavRoute.bookingsOverview.path,
              name: NavRoute.bookingsOverview.name,
              pageBuilder: _pageBuilder,
            ),
            GoRoute(
              path: NavRoute.profile.path,
              name: NavRoute.profile.name,
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

            // admin routes
            GoRoute(
              path: NavRoute.adminCars.path,
              name: NavRoute.adminCars.name,
              pageBuilder: _pageBuilder,
            ),
            GoRoute(
              path: NavRoute.adminUsers.path,
              name: NavRoute.adminUsers.name,
              pageBuilder: _pageBuilder,
            ),
            GoRoute(
              path: NavRoute.adminBookings.path,
              name: NavRoute.adminBookings.name,
              pageBuilder: _pageBuilder,
            ),
          ],
        ),
      ],
      redirect: (context, state) => _guard(context, state));

  GoRouter get router => _router;

  Page<void> _pageBuilder(BuildContext context, GoRouterState state) => NoTransitionPage<void>(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: _getPageByName(state.name ?? NavRoute.pageNotFound.name, state),
      );

  Widget _getPageByName(String pageName, GoRouterState state) {
    var navRoute = NavRoute.values.byName(pageName);
    final args = state.uri.queryParameters;
    final extra = state.extra;
    switch (navRoute) {
      case NavRoute.home:
        return const HomePage();
      case NavRoute.carDetails:
        return CarDetailsPage(args: args, carFromExtraParameters: extra as Car?);
      case NavRoute.rent:
        return RentPage(args: args, carFromExtraParameters: extra as Car?);
      case NavRoute.profile:
        return const ProfilePage();
      case NavRoute.bookingsOverview:
        return const BookingsOverviewPage();
      case NavRoute.login:
        final args = state.uri.queryParameters;
        return LoginPage(args: args);
      case NavRoute.adminCars:
        final args = state.uri.queryParameters;
        return AdminCarsPage(args: args);
      case NavRoute.adminUsers:
        final args = state.uri.queryParameters;
        return AdminUsersPage(args: args);
      case NavRoute.adminBookings:
        final args = state.uri.queryParameters;
        return AdminBookingsPage(args: args);
      default:
        return const PageNotFound();
    }
  }

  Future<String> _guard(BuildContext context, GoRouterState state) async {
    final authService = getIt<AuthService>();
    final isLoggedIn = await authService.isAuthenticated;
    if (noAuthRoutes.contains(state.uri.path)) {
      return _getFullPath(state);
    }
    // Redirect to login if not authenticated (except login route)
    else if (!isLoggedIn && state.uri.path != NavRoute.login.path) {
      return NavRoute.login.path;
    }
    // Redirect to home if user is authenticated and tries to go to login
    else if (isLoggedIn) {
      if (state.uri.path == NavRoute.login.path) {
        return NavRoute.home.path;
      } else {
        final Role role = await authService.user?.role;
        if (adminRoutes.contains(state.uri.path)) {
          // prevent simple users to access the admin routes
          if (role != Role.ADMIN) {
            showSnackBar(SnackBarLevel.warning, 'You do not have access to ${state.uri.path}!');
            return NavRoute.home.path;
          }
        }
        return _getFullPath(state);
      }
    }
    return _getFullPath(state);
  }

  Future<String> _getFullPath(GoRouterState state) async {
    if (state.uri.queryParameters.isNotEmpty) {
      return Future.value('${state.uri.path}?${state.uri.query}');
    }
    return Future.value(state.uri.path);
  }
}
