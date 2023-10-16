import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import 'cars_view_model.dart';

class BookingPage extends ViewModelWidget<BookingViewModel> {
  final Map<String, String> args;
  final dynamic carFromExtraParameters;

  const BookingPage({super.key, required this.args, required this.carFromExtraParameters});

  @override
  Widget builder(BuildContext context, BookingViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Text('Car with id: ${viewModel.car['id']}'),
      ),
    );
  }

  @override
  BookingViewModel viewModelBuilder() {
    return getIt.get<BookingViewModel>(param1: args, param2: carFromExtraParameters);
  }
}
