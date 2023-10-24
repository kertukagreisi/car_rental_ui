import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../resources/dimens.dart';

class BookingCardWidget extends StatelessWidget {
  final Booking booking;
  final Function(int bookingId) onBookingCardItemClick;

  const BookingCardWidget({
    Key? key,
    required this.booking,
    required this.onBookingCardItemClick,
  }) : super(key: key);

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
                padding: const EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0, bottom: 8.0),
                height: 50,
                width: 80,
                child: Image.asset(Images.aurisImage, alignment: Alignment.center, fit: BoxFit.fitWidth),
              ),
              Container(
                margin: const EdgeInsets.only(left: 90.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text('Toyota Auris', style: Dimens.smallHeadTextStyle),
                    ),
                    Wrap(
                      children: [
                        Text(DateFormat("d MMMM y", 'en_US').format(booking.startDate), style: Dimens.extraSmallTextStyle),
                        const Text(' - ', style: Dimens.extraSmallTextStyle),
                        Text(DateFormat("d MMMM y", 'en_US').format(booking.endDate), style: Dimens.extraSmallTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              onBookingCardItemClick(booking.id!);
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: ColoredBox(
              color: AppColors.gray,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Leave rating',
                            style: Dimens.smallTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          const Icon(Icons.navigate_next_outlined, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
