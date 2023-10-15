import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class CarCardWidget extends StatelessWidget {
  final dynamic car;

  const CarCardWidget({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 120,
            width: 120,
            color: AppColors.darkCyan,
            child: Image.asset(Images.ragnarImage, alignment: Alignment.center, fit: BoxFit.fill),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${car['brand']} ${car['model']}',
                style: Dimens.smallHeadTextStyle,
              ),
              Text(
                car['engine'],
                style: Dimens.smallTextStyle,
              ),
              Text(
                '${'2400'} ALL',
                style: Dimens.extraSmallHeadTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
