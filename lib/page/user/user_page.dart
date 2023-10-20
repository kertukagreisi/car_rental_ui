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

import '../../widgets/car_card_widget.dart';
import 'user_view_model.dart';

class UserPage extends ViewModelWidget<UserViewModel> {
  const UserPage({super.key});

  @override
  Widget builder(BuildContext context, UserViewModel viewModel, Widget? child) {
    final TextEditingController searchController = TextEditingController();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Our top rated cars!', style: Dimens.mediumHeadTextStyle),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  viewportFraction: 300 / MediaQuery.of(context).size.width,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: viewModel.user.map((car) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: 250,
                        child: CarCarouselWidget(
                            car: car,
                            onCarCardItemClick: (id) {
                              context.goNamedRoute(NavRoute.booking, queryParams: {'id': '$id'}, extra: car);
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
                  prefixIcon: Icon(Icons.search, color: AppColors.darkBlue),
                ),
                onFieldSubmitted: (value) async {
                  await viewModel.onSearch(value);
                },
              ),
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
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 20.0,
              runSpacing: 16.0,
              children: [
                ...viewModel.displayedCars.map((car) => CarCardWidget(
                    car: car,
                    onCarCardItemClick: (id) {
                      context.goNamedRoute(NavRoute.booking, queryParams: {'id': '$id'}, extra: car);
                    })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  UserViewModel viewModelBuilder() {
    return getIt.get<UserViewModel>();
  }
}
