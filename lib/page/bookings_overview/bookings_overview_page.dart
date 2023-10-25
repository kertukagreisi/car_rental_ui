import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import '../../widgets/booking_card_widget.dart';
import 'bookings_overview_view_model.dart';

class BookingsOverviewPage extends ViewModelWidget<BookingsOverviewViewModel> {
  const BookingsOverviewPage({super.key});

  @override
  Widget builder(BuildContext context, BookingsOverviewViewModel viewModel, Widget? child) {
    ValueNotifier<BookingStatus> tabNotifier = ValueNotifier(BookingStatus.PENDING);
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(18.0),
        child: ValueListenableBuilder(
          valueListenable: tabNotifier,
          builder: (BuildContext context, BookingStatus value, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, left: 4.0, right: 4.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: BookingStatus.values.map((status) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            tabNotifier.value = BookingStatus.values.firstWhere((value) => value == status);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 4.0),
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                color: value.value == status.value ? AppColors.darkCyan : Colors.white,
                                boxShadow: const [BoxShadow(color: AppColors.cyan, blurRadius: 1)],
                                border: Border.all(color: AppColors.cyan),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Text(
                              '${status.value} (${viewModel.bookings.where((booking) => booking.bookingStatus == status).length})',
                              style: Dimens.extraSmallTextStyle
                                  .copyWith(fontWeight: FontWeight.w600, color: value.value == status.value ? Colors.white : AppColors.darkCyan),
                            ),
                          ),
                        );
                      }).toList(growable: false),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: viewModel.bookings.where((booking) => booking.bookingStatus == value).map((filteredBooking) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: BookingCardWidget(booking: filteredBooking, onBookingCardItemClick: (bookingId) {}),
                      );
                    }).toList(growable: false),
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
