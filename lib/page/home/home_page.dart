import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/car_carousel_widget.dart';
import 'package:car_rental_ui/widgets/text_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../shared/flutter_secure_storage_service.dart';
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
                    height: 250,
                    viewportFraction: 300 / MediaQuery.of(context).size.width,
                    enlargeCenterPage: true,
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
                                bool isLoggedIn = await getUserFromSecureStorage() == null;
                                if (context.mounted) {
                                  context.goNamedRoute(isLoggedIn ? NavRoute.book : NavRoute.login, queryParams: {'id': '$id'}, extra: car);
                                }
                              }),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: AppColors.darkCyan),
                ),
                onFieldSubmitted: (value) async {
                  await viewModel.onSearch(value);
                },
              ),
            ),
            if (viewModel.searchValue != '')
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: Wrap(
                              children: [
                                const Text('Showing results for ', style: Dimens.smallTextStyle),
                                Text(viewModel.searchValue, style: Dimens.smallHeadTextStyle),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0.0,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                viewModel.onSearch('');
                              },
                              child: const Icon(Icons.clear, color: AppColors.darkCyan, size: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 12.0,
                children: [Brand.BMW, Brand.VOLKSWAGEN, Brand.MERCEDES_BENZ, Brand.AUDI]
                    .map(
                      (brand) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            viewModel.addBrandFilter = brand;
                          },
                          child: TextContainer(
                              text: brand.value,
                              textColor: Colors.black,
                              backgroundColor: viewModel.brandFiltersValues.contains(brand) ? AppColors.lightPurple : AppColors.lightGray,
                              fontWeight: FontWeight.w300),
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
                        bool isLoggedIn = await getUserFromSecureStorage() != null;
                        if (context.mounted) {
                          context.goNamedRoute(isLoggedIn ? NavRoute.book : NavRoute.login,
                              queryParams: {'id': '$id', 'navRoute': 'booking'}, extra: car);
                        }
                      },
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
}
