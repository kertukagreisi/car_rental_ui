import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class CarCardWidget extends StatelessWidget {
  final Car car;
  final Function(int jobcardId) onCarCardItemClick;
  final double width;

  const CarCardWidget(
      {super.key,
      required this.car,
      required this.onCarCardItemClick,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 8.0, left: 6.0, right: 6.0, bottom: 8.0),
            height: 120,
            width: 160,
            child: Image.asset(Images.aurisImage,
                alignment: Alignment.center, fit: BoxFit.fitWidth),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 6.0, right: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${car.brand.value.replaceAll('_', ' ')} ${car.model} ${car.year}',
                  style: Dimens.smallTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${car.price} €',
                  style: Dimens.mediumHeadTextStyle,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              onCarCardItemClick(car.id!);
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: ColoredBox(
              color: AppColors.darkCyan,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'More details',
                            style: Dimens.mediumTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          const Icon(Icons.navigate_next_outlined,
                              color: Colors.white, size: 18),
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
