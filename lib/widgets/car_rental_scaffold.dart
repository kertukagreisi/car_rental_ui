import 'package:car_rental_ui/shared/extensions.dart';
import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';
import '../navigation/nav_extensions.dart';
import '../navigation/nav_route.dart';
import '../resources/app_colors.dart';
import '../shared/flutter_secure_storage_service.dart';

class CarRentalScaffold extends StatefulWidget {
  const CarRentalScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  State<CarRentalScaffold> createState() => _CarRentalScaffoldState();
}

class _CarRentalScaffoldState extends State<CarRentalScaffold> {
  final _isRailExtended = ValueNotifier(false);
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List<_NavigationElement> get _navElements => [
        _NavigationElement(
          label: 'Cars',
          route: NavRoute.home,
        ),
        _NavigationElement(
          label: 'Bookings',
          route: NavRoute.bookingsOverview,
        ),
        _NavigationElement(
          label: 'User',
          route: NavRoute.user,
        ),
      ];

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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () async {
                    _isRailExtended.value = false;
                    await removeUserFromSecureStorage();
                    if (context.mounted) {
                      context.goNamedRoute(NavRoute.login);
                    }
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Icon(Icons.logout, color: AppColors.darkCyan, size: 20),
                      ),
                      Text('Log Out', style: Dimens.smallHeadTextStyle),
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
          child: Text(
            context.getAppBarTitle(),
            style: Dimens.extraSmallHeadTextStyle.copyWith(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.01 * 12,
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

  BottomNavigationBar _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30),
          label: 'Cars',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_sharp, size: 30),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.darkCyan,
      onTap: (index) {
        _selectedIndex = index;
        var navElement = _navElements[index];
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
