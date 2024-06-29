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
  const CarRentalScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  State<CarRentalScaffold> createState() => _CarRentalScaffoldState();
}

class _CarRentalScaffoldState extends State<CarRentalScaffold> {
  late User? user;
  final _isRailExtended = ValueNotifier(false);
  int _selectedIndex = 0;
  List<_NavigationElement> navElements = [];

  @override
  void initState() {
    super.initState();
    var authService = AuthService();
    user = authService.user;
    if (user == null) {
      navElements = [
        _NavigationElement(
          label: 'Cars',
          route: NavRoute.home,
        ),
        _NavigationElement(
          label: 'Login',
          route: NavRoute.login,
        ),
      ];
    } else {
      if (user?.role == Role.USER) {
        navElements = [
          _NavigationElement(
            label: 'Home',
            route: NavRoute.home,
          ),
          _NavigationElement(
            label: 'Bookings',
            route: NavRoute.bookingsOverview,
          ),
          _NavigationElement(
            label: 'Profile',
            route: NavRoute.profile,
          ),
        ];
      } else {
        navElements = [
          _NavigationElement(
            label: 'Bookings',
            route: NavRoute.adminBookings,
          ),
          _NavigationElement(
            label: 'Cars',
            route: NavRoute.adminCars,
          ),
          _NavigationElement(
            label: 'Users',
            route: NavRoute.adminUsers,
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
            SizedBox(width: 120, child: _buildTopNavPopup()),
          ],
        ));
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        leading: context.currentRoute != NavRoute.home.path
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
        final authService = getIt<AuthService>();
        return _isRailExtended.value
            ? TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                ),
                onPressed: () async {
                  _isRailExtended.value = false;
                  await authService.logout();
                  if (mounted) {
                    if (!context.mounted) return;
                    context.goNamedRoute(NavRoute.login);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray, width: 2.0),
                      color: Colors.white,
                      boxShadow: const [BoxShadow(color: AppColors.lightGray, spreadRadius: 1.0, blurRadius: 2.0)]),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (user != null) ...[
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.account_box, color: AppColors.darkCyan, size: 20),
                            ),
                            Text('Profile', style: Constants.smallHeadTextStyle),
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.logout, color: AppColors.darkCyan, size: 20),
                            ),
                            Text('Log Out', style: Constants.smallHeadTextStyle),
                          ],
                        ),
                      ],
                      if (user == null)
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.login, color: AppColors.darkCyan, size: 20),
                            ),
                            Text('Log In', style: Constants.smallHeadTextStyle),
                          ],
                        ),
                    ],
                  ),
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

  Widget _buildAppBarLeading() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            _isRailExtended.value = !_isRailExtended.value;
          },
          child: const Icon(
            Icons.menu,
            size: 24,
          ),
        ),
      );

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

  NavigationBar _buildBottomNavBar(BuildContext context) {
    return NavigationBar(
      destinations: navElements
          .map((navElement) => NavigationDestination(
                icon: const Icon(Icons.home, size: 30, color: AppColors.gray),
                label: navElement.label,
                selectedIcon: const Icon(Icons.car_crash, size: 30, color: AppColors.darkCyan),
              ))
          .toList(),
      backgroundColor: AppColors.darkCyan,
      selectedIndex: _selectedIndex,
      indicatorColor: Colors.white,
      onDestinationSelected: (index) {
        _selectedIndex = index;
        var navElement = navElements[index];
        navElement.route?.let((route) => context.goNamedRoute(route));
      },
    );
  }
}

class _NavigationElement {
  _NavigationElement({
    required this.label,
    this.route,
  });

  final String label;
  final NavRoute? route;
}
