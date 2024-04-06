import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/images.dart';
import 'package:car_rental_ui/widgets/text_container.dart';
import 'package:flutter/material.dart';

import '../resources/dimens.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(colors: [Colors.white, AppColors.lightCyan]),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          car.model,
                          style: Dimens.mediumHeadTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        car.brand.value.replaceAll('_', ' '),
                        style: Dimens.smallTextStyle.copyWith(fontSize: 10.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextContainer(
                      text: car.color.value,
                      textColor: getTextColor(false, car.color.value),
                      backgroundColor: getTextColor(true, car.color.value),
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        shadowColor: AppColors.darkCyan,
                        side: const BorderSide(color: AppColors.darkCyan)),
                    onPressed: () {
                      onCarCardItemClick(car.id!);
                    },
                    child: const Text('Rent', style: Dimens.smallHeadTextStyle),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(2.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white, spreadRadius: 10, blurRadius: 12)
                    ],
                  ),
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _buildRatingWidget(
                        car.averageRating!, car.reviewsCount!),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(2.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white, spreadRadius: 10, blurRadius: 12)
                    ],
                  ),
                  margin: const EdgeInsets.only(left: 100),
                  height: 120,
                  width: 150,
                  child: Image.asset(Images.aurisImage,
                      alignment: Alignment.center, fit: BoxFit.fitWidth),
                ),
                Text(
                  '${car.price} €',
                  style: Dimens.headTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRatingWidget(double averageRating, int reviewsCount) {
    List<Widget> ratingWidgets = [];
    ratingWidgets.add(
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
            '${double.parse(averageRating.toStringAsFixed(1))} ($reviewsCount)',
            style: Dimens.smallTextStyle.copyWith(color: AppColors.orange)),
      ),
    );
    for (var index = 4; index >= 0; index--) {
      ratingWidgets.add(
        Icon(
            index > 4 - averageRating.floor()
                ? Icons.star
                : Icons.star_border_outlined,
            color: AppColors.orange,
            size: 15.0),
      );
    }
    return ratingWidgets;
  }
}
