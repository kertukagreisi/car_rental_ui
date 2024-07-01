import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/shared/extensions.dart';
import 'package:flutter/material.dart';

import '../../../resources/constants.dart';
import '../navigation/nav_route.dart';
import '../resources/app_colors.dart';
import '../shared/auth_service.dart';
import '../shared/locator.dart';

class CarRentalScaffold extends StatefulWidget {
  CarRentalScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  final AuthService _authService = getIt.get<AuthService>();

  @override
  State<CarRentalScaffold> createState() => _CarRentalScaffoldState();
}

class _CarRentalScaffoldState extends State<CarRentalScaffold> {
  final _isRailExtended = ValueNotifier(false);
  int _selectedIndex = 0;
  List<_NavigationElement> navElements = [];

  @override
  void initState() {
    super.initState();
  }

  void _getNavRoutes() {
    if (!widget._authService.isAuthenticated) {
      navElements = [
        _NavigationElement(
          label: 'Cars',
          route: NavRoute.home,
          iconData: Icons.car_rental,
        ),
        _NavigationElement(
          label: 'Login',
          route: NavRoute.login,
          iconData: Icons.login,
        ),
      ];
    } else {
      if (widget._authService.user?.role == Role.USER) {
        navElements = [
          _NavigationElement(
            label: 'Home',
            route: NavRoute.home,
            iconData: Icons.home,
          ),
          _NavigationElement(
            label: 'Bookings',
            route: NavRoute.bookingsOverview,
            iconData: Icons.list,
          ),
          _NavigationElement(
            label: 'Profile',
            route: NavRoute.profile,
            iconData: Icons.person,
          ),
        ];
      } else {
        navElements = [
          _NavigationElement(
            label: 'Home',
            route: NavRoute.home,
            iconData: Icons.home,
          ),
          _NavigationElement(
            label: 'Bookings',
            route: NavRoute.adminBookings,
            iconData: Icons.list,
          ),
          _NavigationElement(
            label: 'Cars',
            route: NavRoute.adminCars,
            iconData: Icons.list_alt,
          ),
          _NavigationElement(
            label: 'Users',
            route: NavRoute.adminUsers,
            iconData: Icons.group,
          ),
        ];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        bottomNavigationBar: _buildBottomNavBar(context),
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              children: [
                Expanded(
                  child: widget.body,
                ),
              ],
            ),
            _buildTopNavPopup(),
          ],
        ));
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        leading: context.currentRoute != NavRoute.home.path && context.currentRoute != NavRoute.carDetails.path
            ? GestureDetector(
                onTap: () async {
                  await context.navigateToPreviousLevel();
                },
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 14,
                ),
              )
            : const SizedBox(
                width: 36,
              ),
        backgroundColor: AppColors.darkCyan,
        foregroundColor: Colors.white,
        title: _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        leadingWidth: 35.0,
        titleSpacing: 0.0,
        toolbarHeight: 48.0,
      );

  ValueListenableBuilder _buildTopNavPopup() => ValueListenableBuilder<bool>(
      valueListenable: _isRailExtended,
      builder: (_, extended, __) {
        return _isRailExtended.value
            ? Container(
                width: 130,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray, width: 2.0),
                    color: Colors.white,
                    boxShadow: const [BoxShadow(color: AppColors.lightGray, spreadRadius: 1.0, blurRadius: 2.0)]),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget._authService.isAuthenticated) ...[
                      TextButton(
                        style: Constants.clearButtonStyle,
                        onPressed: () {
                          _isRailExtended.value = false;
                          context.goNamedRoute(NavRoute.profile);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.account_box, color: AppColors.darkCyan, size: 22),
                            ),
                            Text('Profile', style: Constants.mediumTextStyle.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        height: 1.0,
                        color: AppColors.cyan.withOpacity(0.5),
                      ),
                      TextButton(
                        style: Constants.clearButtonStyle,
                        onPressed: () async {
                          _isRailExtended.value = false;
                          await widget._authService.logout();
                          _selectedIndex = 0;
                          if (mounted) {
                            context.goNamedRoute(NavRoute.home);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.logout, color: AppColors.darkCyan, size: 22),
                            ),
                            Text('Log Out', style: Constants.mediumTextStyle.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                    if (!widget._authService.isAuthenticated)
                      TextButton(
                        style: Constants.clearButtonStyle,
                        onPressed: () {
                          _isRailExtended.value = false;
                          context.goNamedRoute(NavRoute.login);
                        },
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.login, color: AppColors.darkCyan, size: 20),
                            ),
                            Text('Log In', style: Constants.mediumTextStyle.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            : const SizedBox.shrink();
      });

  Widget _buildAppBarTitle() {
    return Builder(builder: (context) {
      return SizedBox(
        height: 16.0,
        child: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () async {
              await context.navigateToPreviousLevel();
            },
            child: Text(
              context.getAppBarTitle(),
              style: Constants.extraSmallHeadTextStyle.copyWith(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.01 * 12,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAppBarLeading() => ValueListenableBuilder(
      valueListenable: _isRailExtended,
      builder: (BuildContext context, bool extended, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              _isRailExtended.value = !_isRailExtended.value;
            },
            child: Icon(
              extended ? Icons.menu_open : Icons.menu,
              size: 24,
            ),
          ),
        );
      });

  List<Widget> _buildAppBarActions() {
    return [
      GestureDetector(
        child: const Icon(
          Icons.message,
          size: 24,
        ),
      ),
      _buildAppBarLeading(),
    ];
  }

  NavigationBarTheme _buildBottomNavBar(BuildContext context) {
    _getNavRoutes();
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (Set<WidgetState> states) =>
              states.contains(WidgetState.selected) ? const TextStyle(color: Colors.white) : TextStyle(color: AppColors.lightGray.withOpacity(0.6)),
        ),
      ),
      child: NavigationBar(
        destinations: navElements
            .map((navElement) => NavigationDestination(
                  tooltip: navElement.label,
                  icon: Icon(navElement.iconData, size: 30, color: AppColors.lightGray.withOpacity(0.6)),
                  label: navElement.label,
                  selectedIcon: Icon(navElement.iconData, size: 30, color: Colors.white),
                ))
            .toList(),
        selectedIndex: _selectedIndex,
        backgroundColor: AppColors.darkCyan,
        indicatorColor: AppColors.darkCyan,
        surfaceTintColor: AppColors.darkCyan,
        onDestinationSelected: (index) {
          _selectedIndex = index;
          var navElement = navElements[index];
          navElement.route?.let((route) => context.goNamedRoute(route));
        },
      ),
    );
  }
}

class _NavigationElement {
  _NavigationElement({
    required this.label,
    required this.iconData,
    this.route,
  });

  final String label;
  final NavRoute? route;
  final IconData iconData;
}
