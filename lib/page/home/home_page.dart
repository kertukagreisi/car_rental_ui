import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import '../../widgets/car_card.dart';
import 'home_view_model.dart';

class HomePage extends ViewModelWidget<HomeViewModel> {
  const HomePage({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, left: 32.0),
                    child: Text('You have ${viewModel.cars.length} cars registered on the database!', style: Dimens.mediumHeadTextStyle),
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 20.0,
              runSpacing: 16.0,
              children: [
                ...viewModel.cars.map((car) => CarCardWidget(car: car)),
              ],
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
