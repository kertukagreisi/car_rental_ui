import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../resources/images.dart';
import 'car_details_view_model.dart';

class CarDetailsPage extends ViewModelWidget<CarDetailsViewModel> {
  final Map<String, String> args;
  final Car? carFromExtraParameters;

  const CarDetailsPage({super.key, required this.args, required this.carFromExtraParameters});

  @override
  Widget builder(BuildContext context, CarDetailsViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: _buildRatingWidget(viewModel.car.averageRating!, viewModel.car.reviewsCount!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('${viewModel.car.brand} ${viewModel.car.model}', style: Constants.headTextStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('${viewModel.car.engine} ${viewModel.car.fuelType}', style: Constants.mediumHeadTextStyle.copyWith(color: AppColors.gray)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 350,
                  enableInfiniteScroll: false,
                  viewportFraction: 500 / MediaQuery.of(context).size.width,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: ['1', '2', '3'].map((picture) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 300,
                        width: 300,
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(Images.aurisImage, alignment: Alignment.center, fit: BoxFit.fill),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextButton(
                  style: Constants.clearButtonStyle,
                  onPressed: () {
                    context.goNamedRoute(NavRoute.rent, queryParams: args, extra: carFromExtraParameters);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: AppColors.darkCyan,
                    ),
                    child: Text(
                      'Rent',
                      style: Constants.mediumHeadTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  CarDetailsViewModel viewModelBuilder() {
    return getIt.get<CarDetailsViewModel>(param1: args, param2: carFromExtraParameters);
  }

  List<Widget> _buildRatingWidget(double averageRating, int reviewsCount) {
    List<Widget> ratingWidgets = [];
    for (var index = 4; index >= 0; index--) {
      ratingWidgets.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(index > 4 - averageRating.floor() ? Icons.star : Icons.star_border_outlined, color: AppColors.yellow),
      ));
    }
    ratingWidgets.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 2.0),
        child: Text('($reviewsCount)', style: Constants.headTextStyle.copyWith(color: AppColors.yellow)),
      ),
    );

    return ratingWidgets;
  }
}
