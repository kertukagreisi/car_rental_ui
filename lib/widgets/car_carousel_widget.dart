import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:car_rental_ui/widgets/text_container.dart';
import 'package:flutter/material.dart';

import '../resources/constants.dart';
import '../shared/helpers.dart';

class CarCarouselWidget extends StatelessWidget {
  final Car car;
  final Function(int jobcardId) onCarCardItemClick;

  const CarCarouselWidget({
    super.key,
    required this.car,
    required this.onCarCardItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onCarCardItemClick(car.id!);
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.gray.withOpacity(0.6), width: 1.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkCyan.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            car.model,
                            style: Constants.mediumHeadTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          car.brand.value.replaceAll('_', ' '),
                          style: Constants.smallTextStyle.copyWith(fontSize: 10.0, color: AppColors.gray),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
                      _buildRatingStars(car.averageRating!),
                      Text('Rating: ${double.parse(car.averageRating!.toStringAsFixed(1))} (${car.reviewsCount!})',
                          style: Constants.extraSmallTextStyle.copyWith(fontWeight: FontWeight.w500, color: AppColors.orange)),
                    ]),
                  ],
                ),
                Constants.mediumSizedBox,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                boxShadow: [BoxShadow(color: AppColors.gray.withOpacity(0.6), blurRadius: 1, spreadRadius: 0.5)]),
                            child: TextContainer(
                                text: car.color.value,
                                textColor: getTextColor(false, car.color.value),
                                backgroundColor: getTextColor(true, car.color.value),
                                fontWeight: FontWeight.w400,
                                fontSize: 10.0),
                          ),
                          Text(
                            '${car.price} €',
                            style: Constants.mediumHeadTextStyle,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          boxShadow: const [BoxShadow(color: Colors.white, spreadRadius: 8, blurRadius: 8)],
                        ),
                        height: 130,
                        width: 150,
                        child: Image.asset(Images.aurisImage, alignment: Alignment.center, fit: BoxFit.fitWidth),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _buildRatingStars(double averageRating) {
    List<Widget> starColumns = [];
    for (var index = 4; index >= 0; index--) {
      starColumns.add(
        Icon(index > 4 - averageRating.floor() ? Icons.star : Icons.star_border_outlined, color: AppColors.orange, size: 15.0),
      );
    }
    return Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, children: starColumns);
  }
}
