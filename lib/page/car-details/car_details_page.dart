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
import '../../shared/helpers.dart';
import 'car_details_view_model.dart';

class CarDetailsPage extends ViewModelWidget<CarDetailsViewModel> {
  final Map<String, String> args;
  final Car? carFromExtraParameters;

  const CarDetailsPage({super.key, required this.args, required this.carFromExtraParameters});

  @override
  Widget builder(BuildContext context, CarDetailsViewModel viewModel, Widget? child) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _buildCarouselWidget(viewModel, context),
              Container(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if (viewModel.car.averageRating != 0.0) ...[
                          _buildRatingWidget(viewModel.car.averageRating!),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text('Rating: ${viewModel.car.averageRating!} (${viewModel.car.reviewsCount!})',
                                style: Constants.titleTextStyle.copyWith(fontWeight: FontWeight.w600, color: AppColors.orange)),
                          ),
                        ]
                      ]),
                    ),
                    ..._buildCarDetails(viewModel)
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildHeaderWidget(viewModel, context),
        _buildBottomWidget(viewModel, context)
      ],
    );
  }

  Widget _buildCarouselWidget(CarDetailsViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 250,
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
    );
  }

  Widget _buildHeaderWidget(CarDetailsViewModel viewModel, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkCyan,
        boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4.0, spreadRadius: 0.2)],
        border: Border(
          top: BorderSide(color: Colors.white),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                context.goNamedRoute(NavRoute.home);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              style: IconButton.styleFrom(backgroundColor: AppColors.darkCyan, hoverColor: AppColors.darkCyan),
              padding: const EdgeInsets.all(0)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(viewModel.car.brand.value, style: Constants.smallHeadTextStyle.copyWith(fontSize: 10.0, color: AppColors.gray)),
              Text(viewModel.car.model, style: Constants.mediumTextStyle.copyWith(fontWeight: FontWeight.w600, color: Colors.white)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('${viewModel.car.price} €', style: Constants.mediumHeadTextStyle.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingWidget(double averageRating) {
    List<Widget> stars = [];
    for (var index = 4; index >= 0; index--) {
      stars.add(Icon(index > 4 - averageRating.floor() ? Icons.star : Icons.star_border_outlined, color: AppColors.orange, size: 20.0));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: stars);
  }

  Widget _buildBottomWidget(CarDetailsViewModel viewModel, BuildContext context) {
    return Positioned(
        right: 0.0,
        left: 0.0,
        bottom: 0.0,
        child: InkWell(
          onTap: () {
            context.goNamedRoute(NavRoute.rent, queryParams: {'id': '${viewModel.car.id}'});
          },
          child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.darkCyan,
                boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4.0, spreadRadius: 0.2)],
                border: Border(
                  bottom: BorderSide(color: Colors.white),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit_calendar_sharp, size: 18, color: Colors.white),
                  Constants.smallSizedBox,
                  Text('Rent Car', style: Constants.mediumHeadTextStyle.copyWith(color: Colors.white)),
                ],
              )),
        ));
  }

  List<Widget> _buildCarDetails(CarDetailsViewModel viewModel) {
    return [
      Container(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.gray))),
        margin: const EdgeInsets.only(left: 6.0, bottom: 12.0),
        child: const Text('Details', style: Constants.headTextStyle),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.car_rental, color: AppColors.darkGray, size: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
            child: Text(viewModel.car.brand.value.replaceAll('_', ' '), style: Constants.mediumTextStyle.copyWith(color: AppColors.darkGray)),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.calendar_month, color: AppColors.darkGray, size: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
            child: Text('${viewModel.car.year}', style: Constants.mediumTextStyle.copyWith(color: AppColors.darkGray)),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.candlestick_chart, color: AppColors.darkGray, size: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
            child: Text(viewModel.car.transmission.value, style: Constants.mediumTextStyle.copyWith(color: AppColors.darkGray)),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.account_tree_outlined, color: AppColors.darkGray, size: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
            child: Text(viewModel.car.engine, style: Constants.mediumTextStyle.copyWith(color: AppColors.darkGray)),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.color_lens, color: getTextColor(true, viewModel.car.color.value), size: 20),
          Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
            child: Text(viewModel.car.color.value, style: Constants.mediumTextStyle.copyWith(color: getTextColor(true, viewModel.car.color.value))),
          ),
        ],
      )
    ];
  }

  @override
  CarDetailsViewModel viewModelBuilder() {
    return getIt.get<CarDetailsViewModel>(param1: args, param2: carFromExtraParameters);
  }
}
