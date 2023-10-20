import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/ui_type/date_picker_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';
import '../../resources/images.dart';
import 'bookings_view_model.dart';

class BookingPage extends ViewModelWidget<BookingViewModel> {
  final Map<String, String> args;
  final Car? carFromExtraParameters;

  const BookingPage({super.key, required this.args, required this.carFromExtraParameters});

  @override
  Widget builder(BuildContext context, BookingViewModel viewModel, Widget? child) {
    final formKey = GlobalKey<FormBuilderState>();
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
                children: _buildRatingWidget(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('${viewModel.car.brand} ${viewModel.car.model}', style: Dimens.headTextStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('${viewModel.car.engine} ${viewModel.car.fuelType}', style: Dimens.mediumHeadTextStyle.copyWith(color: AppColors.gray)),
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
                            child: Image.asset(Images.ragnarImage, alignment: Alignment.center, fit: BoxFit.fill),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text('Select your options', style: Dimens.mediumTextStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FormBuilder(
                key: formKey,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 12.0,
                  children: [
                    DatePickerWidget(
                        label: 'Start Date',
                        mandatory: true,
                        initialValue: viewModel.startDate,
                        startsFromToday: true,
                        onChange: (value) {
                          viewModel.setTotalToBePayed(true, value);
                        }),
                    DatePickerWidget(
                        label: 'End Date',
                        mandatory: true,
                        initialValue: viewModel.endDate,
                        startsFromToday: true,
                        onChange: (value) {
                          viewModel.setTotalToBePayed(false, value);
                        })
                  ],
                ),
              ),
            ),
            if (viewModel.datesDifference <= 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'The end date should be after the start date!',
                  style: Dimens.smallTextStyle.copyWith(color: AppColors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${viewModel.totalPrice} €', style: Dimens.headTextStyle),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGray, padding: const EdgeInsets.all(8.0)),
                            onPressed: viewModel.datesDifference > 0
                                ? () async {
                                    formKey.currentState?.save();
                                    if (formKey.currentState!.validate()) {
                                      await viewModel
                                          .renatCar(formKey.currentState!.value, context)
                                          .then((value) => context.goNamedRoute(NavRoute.home));
                                    }
                                  }
                                : null,
                            child: Text('Rent', style: Dimens.mediumTextStyle.copyWith(color: Colors.white)),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(8.0)),
                          onPressed: () {
                            context.goNamedRoute(NavRoute.home);
                          },
                          child: Text('Cancel', style: Dimens.mediumTextStyle.copyWith(color: AppColors.darkGray)),
                        ),
                      ],
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
  BookingViewModel viewModelBuilder() {
    return getIt.get<BookingViewModel>(param1: args, param2: carFromExtraParameters);
  }

  List<Widget> _buildRatingWidget(int rating) {
    List<Widget> stars = [];
    for (var index = 4; index >= 0; index--) {
      stars.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(index > 4 - rating ? Icons.star : Icons.star_border_outlined, color: AppColors.yellow),
      ));
    }
    return stars;
  }
}
