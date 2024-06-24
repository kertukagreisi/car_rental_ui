import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/button_with_icon_widget.dart';
import 'package:car_rental_ui/widgets/cancel_button_widget.dart';
import 'package:car_rental_ui/widgets/car_carousel_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/images.dart';
import '../../widgets/car_card_widget.dart';
import 'home_view_model.dart';

class HomePage extends ViewModelWidget<HomeViewModel> {
  const HomePage({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    final TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (viewModel.cars.where((car) => car.averageRating! >= 4.0).isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    height: 250,
                    viewportFraction: 300 / MediaQuery.of(context).size.width,
                    autoPlay: true,
                  ),
                  items: viewModel.cars.where((car) => car.averageRating! >= 4.0).map((car) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: 250,
                          child: CarCarouselWidget(
                              car: car,
                              onCarCardItemClick: (id) async {
                                if (context.mounted) {
                                  context.goNamedRoute(NavRoute.carDetails, queryParams: {'id': '$id'}, extra: car);
                                }
                              }),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            Container(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 100,
                    height: 34,
                    child: TextFormField(
                      controller: searchController,
                      style: Dimens.smallTextStyle,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 4.0),
                        hintText: 'Search',
                        border: OutlineInputBorder(borderSide: const BorderSide(width: 1.4), borderRadius: BorderRadius.circular(4.0)),
                      ),
                      onFieldSubmitted: (value) async {
                        await viewModel.onSearch(value);
                      },
                    ),
                  ),
                  Dimens.smallSizedBox,
                  ButtonWithIcon(
                      text: 'Search',
                      onPressed: () {
                        viewModel.onSearch(searchController.text);
                      },
                      icon: Icons.search,
                      dark: true),
                  Dimens.smallSizedBox,
                  CancelButton(
                      text: 'Clear',
                      onPressed: () {
                        viewModel.onSearch('');
                      })
                ],
              ),
            ),
            if (viewModel.searchValue != '')
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Wrap(
                  children: [
                    const Text('Showing results for ', style: Dimens.mediumTextStyle),
                    Text(viewModel.searchValue, style: Dimens.mediumHeadTextStyle),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 12.0,
                children: [Brand.AUDI, Brand.MERCEDES_BENZ, Brand.BMW, Brand.FORD, Brand.TOYOTA, Brand.VOLKSWAGEN]
                    .map(
                      (brand) => Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: TextButton(
                          style: Dimens.clearButtonStyle,
                          onPressed: () {
                            viewModel.addBrandFilter = brand;
                          },
                          child: _getIconButtonForBrand(brand, viewModel.brandFiltersValues.contains(brand)),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  ...viewModel.displayedCars.map(
                    (car) => CarCardWidget(
                      car: car,
                      onCarCardItemClick: (id) async {
                        if (context.mounted) {
                          if (context.mounted) {
                            context.goNamedRoute(NavRoute.carDetails, queryParams: {'id': '$id'}, extra: car);
                          }
                        }
                      },
                      width: _getWidth(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder() {
    return getIt.get<HomeViewModel>();
  }

  Widget _getIconButtonForBrand(Brand brand, bool isActive) {
    switch (brand) {
      case Brand.AUDI:
        return Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: isActive ? AppColors.darkCyan : AppColors.lightGray,
          ),
          padding: const EdgeInsets.all(4.0),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(isActive ? Colors.white : AppColors.darkCyan, BlendMode.srcIn),
            child: SvgPicture.asset(
              Images.audiIcon,
            ),
          ),
        );
      case Brand.MERCEDES_BENZ:
        return Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: isActive ? AppColors.darkCyan : AppColors.lightGray,
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(isActive ? Colors.white : AppColors.darkCyan, BlendMode.srcIn),
            child: SvgPicture.asset(
              Images.benzIcon,
            ),
          ),
        );
      case Brand.BMW:
        return Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: isActive ? AppColors.darkCyan : AppColors.lightGray,
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(isActive ? Colors.white : AppColors.darkCyan, BlendMode.srcIn),
            child: SvgPicture.asset(
              Images.bmwIcon,
            ),
          ),
        );
      case Brand.FORD:
        return Container(
          width: 65,
          height: 40,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: isActive ? AppColors.darkCyan : AppColors.lightGray,
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(isActive ? Colors.white : AppColors.darkCyan, BlendMode.srcIn),
            child: SvgPicture.asset(
              Images.fordIcon,
            ),
          ),
        );
      case Brand.TOYOTA:
        return Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: isActive ? AppColors.darkCyan : AppColors.lightGray,
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(isActive ? Colors.white : AppColors.darkCyan, BlendMode.srcIn),
            child: SvgPicture.asset(
              Images.toyotaIcon,
            ),
          ),
        );
      case Brand.VOLKSWAGEN:
        return Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: isActive ? AppColors.darkCyan : AppColors.lightGray,
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(isActive ? Colors.white : AppColors.darkCyan, BlendMode.srcIn),
            child: SvgPicture.asset(
              Images.volkswagenIcon,
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  double _getWidth(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 300) {
      return screenWidth;
    } else if (screenWidth >= 300 && screenWidth < 600) {
      return MediaQuery.of(context).size.width / 2 - 20;
    } else if (screenWidth >= 600 && screenWidth < 850) {
      return MediaQuery.of(context).size.width / 3 - 30;
    } else if (screenWidth >= 850 && screenWidth < 1200) {
      return MediaQuery.of(context).size.width / 4 - 40;
    } else if (screenWidth >= 1200) {
      return MediaQuery.of(context).size.width / 5 - 50;
    }
    return MediaQuery.of(context).size.width / 2 - 20;
  }
}
