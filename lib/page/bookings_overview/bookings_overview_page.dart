import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import 'bookings_overview_view_model.dart';

class BookingsOverviewPage extends ViewModelWidget<BookingsOverviewViewModel> {
  const BookingsOverviewPage({super.key});

  @override
  Widget builder(BuildContext context, BookingsOverviewViewModel viewModel, Widget? child) {
    ValueNotifier<BookingStatus> tabNotifier = ValueNotifier(BookingStatus.PENDING);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: tabNotifier,
          builder: (BuildContext context, BookingStatus value, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Wrap(
                    spacing: 30.0,
                    children: BookingStatus.values.map((status) {
                      return TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: value.value == status.value ? AppColors.gray : Colors.white,
                          ),
                          onPressed: () {
                            tabNotifier.value = BookingStatus.values.firstWhere((value) => value == status);
                          },
                          child: Text(status.value, style: Dimens.smallHeadTextStyle));
                    }).toList(growable: false),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: viewModel.bookings
                        .where((booking) => booking.bookingStatus == value)
                        .map((booking) => Padding(padding: const EdgeInsets.only(bottom: 8.0), child: Text('${booking.startDate}')))
                        .toList(growable: false),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  BookingsOverviewViewModel viewModelBuilder() {
    return getIt.get<BookingsOverviewViewModel>();
  }
}
