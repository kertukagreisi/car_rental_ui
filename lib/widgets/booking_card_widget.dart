import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:car_rental_ui/widgets/ui_type/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../resources/dimens.dart';

class BookingCardWidget extends StatelessWidget {
  final Booking booking;
  final Function(int bookingId) onBookingCardItemClick;

  const BookingCardWidget({
    super.key,
    required this.booking,
    required this.onBookingCardItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkCyan.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 6.0, right: 6.0, bottom: 8.0),
                height: 50,
                width: 80,
                child: Image.asset(Images.aurisImage,
                    alignment: Alignment.center, fit: BoxFit.fitWidth),
              ),
              Container(
                margin: const EdgeInsets.only(left: 90.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                          '${booking.car.brand.value.replaceAll('_', ' ')} ${booking.car.model.toUpperCase()}',
                          style: Dimens.smallHeadTextStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Wrap(
                        children: [
                          Text(
                              DateFormat('d MMMM y', 'en_US')
                                  .format(booking.startDate),
                              style: Dimens.smallTextStyle),
                          Text(DateFormat(' - ').format(booking.startDate),
                              style: Dimens.smallTextStyle),
                          Text(
                              DateFormat('d MMMM y', 'en_US')
                                  .format(booking.endDate),
                              style: Dimens.smallTextStyle),
                        ],
                      ),
                    ),
                    if (booking.bookingStatus == BookingStatus.COMPLETED &&
                        booking.rating != null)
                      _buildRatingWidget(booking.rating!.rating),
                  ],
                ),
              ),
            ],
          ),
          TextButton(
            style: Dimens.clearButtonStyle,
            onPressed: () {
              onBookingCardItemClick(booking.id!);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: _buildPopupContentWidgets(context),
                        ),
                      ),
                    );
                  });
            },
            child: ColoredBox(
              color: AppColors.gray,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  booking.bookingStatus ==
                                              BookingStatus.COMPLETED &&
                                          booking.rating == null
                                      ? 'Leave rating'
                                      : 'View Details',
                                  style: Dimens.smallTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Icon(Icons.navigate_next_outlined,
                                    color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${booking.total} €',
                      style: Dimens.mediumHeadTextStyle
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPopupContentWidgets(BuildContext context) {
    final ValueNotifier<int> ratingNotifier = ValueNotifier(0);
    final ratingFormKey = GlobalKey<FormBuilderState>();
    List<Widget> popupColumns = [];
    popupColumns.add(
      Row(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              color: AppColors.gray,
              margin: const EdgeInsets.only(bottom: 20.0),
              child: booking.bookingStatus == BookingStatus.COMPLETED &&
                      booking.rating == null
                  ? Text('Leave a rating for yor booking!',
                      style: Dimens.smallHeadTextStyle
                          .copyWith(color: Colors.white))
                  : Text('Booking Details',
                      style: Dimens.smallHeadTextStyle
                          .copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
    popupColumns.add(Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        spacing: 25.0,
        runSpacing: 30.0,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Car Model',
                  style:
                      Dimens.smallHeadTextStyle.copyWith(color: AppColors.gray),
                ),
              ),
              Text('${booking.car.brand} ${booking.car.model}',
                  style: Dimens.smallTextStyle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Time of ${booking.bookingStatus == BookingStatus.CANCELED ? 'Canceling' : 'Booking'}',
                  style:
                      Dimens.smallHeadTextStyle.copyWith(color: AppColors.gray),
                ),
              ),
              Text(DateFormat('d MMMM y', 'en_US').format(booking.timeStamp),
                  style: Dimens.smallTextStyle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Start Date',
                  style:
                      Dimens.smallHeadTextStyle.copyWith(color: AppColors.gray),
                ),
              ),
              Text(DateFormat('d MMMM y', 'en_US').format(booking.startDate),
                  style: Dimens.smallTextStyle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'End Date',
                  style:
                      Dimens.smallHeadTextStyle.copyWith(color: AppColors.gray),
                ),
              ),
              Text(DateFormat('d MMMM y', 'en_US').format(booking.endDate),
                  style: Dimens.smallTextStyle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Total Payed',
                  style:
                      Dimens.smallHeadTextStyle.copyWith(color: AppColors.gray),
                ),
              ),
              Text('${booking.total} €', style: Dimens.smallTextStyle),
            ],
          ),
        ],
      ),
    ));

    if (booking.bookingStatus == BookingStatus.COMPLETED &&
        booking.rating == null) {
      popupColumns.add(
        FormBuilder(
          key: ratingFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: ratingNotifier,
                builder: (BuildContext context, value, Widget? child) {
                  List<Widget> starWidgets = [];
                  for (var index = 4; index >= 0; index--) {
                    starWidgets.add(TextButton(
                      style: Dimens.clearButtonStyle,
                      onPressed: () {
                        ratingNotifier.value = 4 - index;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                            index > 3 - value
                                ? Icons.star
                                : Icons.star_border_outlined,
                            color: AppColors.yellow),
                      ),
                    ));
                  }
                  return Wrap(children: starWidgets);
                },
              ),
              TextInputWidget(
                  label: 'Comment',
                  mandatory: false,
                  placeholder: 'Comment',
                  width: 250,
                  onChange: (value) {}),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6.0),
                          backgroundColor: AppColors.darkCyan),
                      onPressed: () async {
                        ratingFormKey.currentState!.save();
                        Rating rating = Rating(
                            rating: ratingNotifier.value + 1,
                            comment:
                                ratingFormKey.currentState?.value['Comment'],
                            timeStamp: DateTime.now(),
                            car: booking.car,
                            user: booking.user);
                        await CarRentalApi.ratingEndpointApi
                            .ratingsCreatePost(
                                bookingId: booking.id,
                                carId: booking.car.id,
                                userId: booking.user.id,
                                rating: rating)
                            .then((value) => showSnackBar(SnackBarLevel.success,
                                'Rating saved successfully!'))
                            .onError((error, stackTrace) => showSnackBar(
                                SnackBarLevel.error,
                                'Couldn\'t save booking! There was an error!'));
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Save',
                        style: Dimens.mediumTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6.0),
                        side: const BorderSide(color: AppColors.darkCyan),
                        shadowColor: AppColors.darkCyan),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: Dimens.mediumTextStyle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      popupColumns.add(
        Container(
          margin: const EdgeInsets.only(top: 14.0),
          child: TextButton(
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                side: const BorderSide(color: AppColors.darkCyan),
                shadowColor: AppColors.darkCyan),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: Dimens.mediumTextStyle,
            ),
          ),
        ),
      );
    }
    return popupColumns;
  }

  Widget _buildRatingWidget(int rating) {
    List<Widget> starWidgets = [];
    for (var index = 4; index >= 0; index--) {
      starWidgets.add(Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: Icon(
            index > 3 - rating ? Icons.star : Icons.star_border_outlined,
            color: AppColors.yellow,
            size: 16.0),
      ));
    }
    return Row(children: starWidgets);
  }
}
