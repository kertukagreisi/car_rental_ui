import 'package:car_rental_ui/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/dimens.dart';
import '../navigation/nav_extensions.dart';
import '../navigation/nav_route.dart';
import '../resources/app_colors.dart';
import '../resources/images.dart';

const _railIconSize = 56.0;
const _railLabelSize = 192.0;
const _railItemSelectedColor = Colors.white;
const _railItemUnselectedColor = AppColors.darkBlue;
const _railBackgroundSelectedColor = AppColors.darkBlue;
const _railBackgroundUnselectedColor = Colors.white;

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
  int? _railSelectedIndex;

  @override
  void initState() {
    super.initState();
  }

  List<_NavigationElement> get _navElements => [
        _NavigationElement(
          imagePath: Images.ownerIcon,
          label: 'Owners',
          route: NavRoute.home,
        ),
        _NavigationElement(
          imagePath: Images.carIcon,
          label: 'Cars',
          route: NavRoute.booking,
        ),
      ];

  int? _findRailSelectedIndex() {
    var currentRoute = context.currentRoute;
    var index = _navElements.indexWhere((navElement) => navElement.route?.path == currentRoute);
    return index > -1 ? index : null;
  }

  @override
  Widget build(BuildContext context) {
    _railSelectedIndex = _findRailSelectedIndex();
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: widget.body,
                ),
                Container(
                  child: _buildNavigationRail(),
                ),
              ],
            ),
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

  ValueListenableBuilder _buildNavigationRail() => ValueListenableBuilder<bool>(
      valueListenable: _isRailExtended,
      builder: (_, extended, __) {
        return _isRailExtended.value
            ? NavigationRail(
                minWidth: _railIconSize,
                extended: extended,
                labelType: NavigationRailLabelType.none,
                selectedIndex: _railSelectedIndex,
                destinations: [
                  for (int i = 0; i < _navElements.length; i++) _buildRailDestination(extended, (i == _railSelectedIndex), _navElements[i])
                ],
                trailing: Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildTrailingWidget(
                            extended,
                            'Collapse',
                            Images.collapseIcon,
                            null,
                            () {
                              _isRailExtended.value = !_isRailExtended.value;
                            },
                          ),
                          Dimens.smallSizedBox,
                          _buildTrailingWidget(extended, 'Help', Images.helpIcon, null, null),
                          Dimens.smallSizedBox,
                        ],
                      )),
                ),
                onDestinationSelected: (index) {
                  _railSelectedIndex = index;
                  var navElement = _navElements[index];
                  navElement.route?.let((route) => context.goNamedRoute(route));
                },
              )
            : const SizedBox.shrink();
      });

  NavigationRailDestination _buildRailDestination(bool isExtended, bool isSelected, _NavigationElement element) => NavigationRailDestination(
        icon: _buildRailIcon(isExtended, isSelected, element),
        label: _buildRailLabel(isSelected, element.label),
        padding: EdgeInsets.zero,
      );

  Widget _buildRailLabel(bool isSelected, String label) => DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? _railBackgroundSelectedColor : _railBackgroundUnselectedColor,
        ),
        child: SizedBox(
          width: _railLabelSize,
          height: _railIconSize,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: Dimens.smallTextStyle.copyWith(color: isSelected ? _railItemSelectedColor : _railItemUnselectedColor),
            ),
          ),
        ),
      );

  Widget _buildRailIcon(bool isExtended, bool isSelected, _NavigationElement element) {
    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? _railBackgroundSelectedColor : _railBackgroundUnselectedColor,
      ),
      child: SizedBox(
        width: _railIconSize,
        height: _railIconSize,
        child: SvgPicture.asset(
          element.imagePath,
          colorFilter: ColorFilter.mode(isSelected ? _railItemSelectedColor : _railItemUnselectedColor, BlendMode.srcIn),
          fit: BoxFit.scaleDown,
          width: 16,
          height: 16,
        ),
      ),
    );

    if (!isExtended) {
      result = Tooltip(
        message: element.label,
        child: result,
      );
    }
    return result;
  }

  Widget _buildAppBarTitle() {
    return Builder(builder: (context) {
      return SizedBox(
        height: 16.0,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            context.getAppBarTitle(),
            style: Dimens.extraSmallHeadTextStyle.copyWith(
              fontSize: 16,
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

  Widget _buildTrailingWidget(bool extended, String title, String iconPath, String? extendedIconPath, Function()? onTap) {
    return SizedBox(
      width: extended ? _railIconSize + _railLabelSize : _railIconSize,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: extended ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
              height: 10,
              child: SvgPicture.asset(
                extendedIconPath != null && extended ? extendedIconPath : iconPath,
                fit: BoxFit.scaleDown,
                width: 10,
                height: 10,
              ),
            ),
            extended
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      style: Dimens.smallTextStyle,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class _NavigationElement {
  _NavigationElement({
    required this.imagePath,
    required this.label,
    this.route,
  });

  final String imagePath;
  final String label;
  final NavRoute? route;
}
