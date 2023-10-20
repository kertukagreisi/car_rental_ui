import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class CarCarouselWidget extends StatelessWidget {
  final Car car;
  final Function(int jobcardId) onCarCardItemClick;

  const CarCarouselWidget({
    Key? key,
    required this.car,
    required this.onCarCardItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 5,
            offset: const Offset(2, 3),
          )
        ],
      ),
      child: Stack(
        children: [
          SizedBox(
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.model!,
                      style: Dimens.smallHeadTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      car.brand!.value.replaceAll('_', ' '),
                      style: Dimens.extraSmallHeadTextStyle.copyWith(fontSize: 10.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGray, padding: const EdgeInsets.all(8.0)),
                  onPressed: () {
                    onCarCardItemClick(car.id!);
                  },
                  child: Text('Rent', style: Dimens.smallTextStyle.copyWith(color: Colors.white)),
                ),
                Text(
                  '${car.price ?? 0} €',
                  style: Dimens.mediumHeadTextStyle,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(left: 100),
              height: 100,
              width: 100,
              child: Image.asset(Images.ragnarImage, alignment: Alignment.center, fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }
}
