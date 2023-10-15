import 'package:car_rental_ui/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _progressIndicatorSize = 80.0;
const _strokeWidth = 6.0;

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: _progressIndicatorSize,
            height: _progressIndicatorSize,
            child: CircularProgressIndicator(
              strokeWidth: _strokeWidth,
            ),
          ),
          RotationTransition(
            turns: const AlwaysStoppedAnimation(0.2),
            child: SvgPicture.asset(
              Images.carIcon,
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
