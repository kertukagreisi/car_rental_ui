import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class CarCardWidget extends StatelessWidget {
  final dynamic car;
  final Function(int jobcardId) onCarCardItemClick;

  const CarCardWidget({
    Key? key,
    required this.car,
    required this.onCarCardItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onCarCardItemClick(car['id']);
        },
        child: Container(
          width: 150,
          height: 180,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightBlue.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(1, 3),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: 100,
                width: 140,
                color: AppColors.darkCyan,
                child: Image.asset(Images.ragnarImage, alignment: Alignment.center, fit: BoxFit.fill),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car['brand']} ${car['model']}',
                    style: Dimens.smallHeadTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    car['engine'],
                    style: Dimens.smallTextStyle,
                  ),
                  const Text(
                    '${'2400'} ALL',
                    style: Dimens.extraSmallHeadTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
