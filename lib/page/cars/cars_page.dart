import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'cars_view_model.dart';

class CarsPage extends ViewModelWidget<CarsViewModel> {
  const CarsPage({super.key});

  @override
  Widget builder(BuildContext context, CarsViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(

      ),
    );
  }

  @override
  CarsViewModel viewModelBuilder() {
    return getIt.get<CarsViewModel>();
  }
}
