import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'fonts.dart';

class Dimens {
  const Dimens._();

  static const smallPadding = EdgeInsets.all(8.0);
  static const mediumPadding = EdgeInsets.all(16);
  static const largePadding = EdgeInsets.all(24);

  static const mediumSpacing = 16.0;
  static const largeSpacing = 24.0;
  static const bigSvgPictureSize = 100.0;
  static const smallSvgPictureSize = 20.0;
  static const extraSmallSvgPictureSize = 16.0;
  static const smallSizedBox = SizedBox(width: 8, height: 8);
  static const mediumSizedBox = SizedBox(width: 24, height: 24);
  static const largeSizedBox = SizedBox(width: 48, height: 8);
  static const mediumSizedBoxHeight = SizedBox(width: 8, height: 16);
  static const largeSizedBoxHeight = SizedBox(width: 48, height: 36);
  static const smallBorderRadius = 4.0;
  static const defaultElevation = 8.0;
  static const defaultScrollbarThickness = 8.0;
  static const filterButtonHeight = 56.0;
  static const filterButtonWidth = 392.0;
  static const filePickerHeightNoFiles = 66.0;
  static const filePickerHeightFiles = 110.0;

  static const fontSizeSmall = 10.0;
  static const fontSizeMedium = 16.0;
  static const tooltipSize = 20.0;

  // text styles
  static const lightTitleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: Fonts.trajanHead,
    fontWeight: FontWeight.normal,
  );

  static const headTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 24,
    fontFamily: Fonts.trajanHead,
    fontWeight: FontWeight.bold,
  );

  static const screenTitleStyle = TextStyle(
    color: AppColors.lightGray,
    fontSize: 24,
    fontFamily: Fonts.trajanHead,
  );

  static const extraSmallHeadTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 12,
    fontFamily: Fonts.trajanHead,
    fontWeight: FontWeight.bold,
  );

  static const smallHeadTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 14,
    fontFamily: Fonts.trajanHead,
    fontWeight: FontWeight.bold,
  );

  static const mediumHeadTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 16,
    fontFamily: Fonts.trajanHead,
    fontWeight: FontWeight.bold,
  );

  static const mediumTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 16,
    fontFamily: Fonts.trajan,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.01 * 16,
  );

  static const smallTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 14,
    fontFamily: Fonts.trajan,
    fontWeight: FontWeight.normal,
  );

  static const extraSmallTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 12,
    fontFamily: Fonts.trajan,
    fontWeight: FontWeight.normal,
  );

  static const radioLabelTextStyle = TextStyle(
    color: AppColors.gray,
    fontSize: 10,
    fontFamily: Fonts.trajan,
    fontWeight: FontWeight.normal,
  );

  static const titleTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 18,
    fontFamily: Fonts.trajanHead,
    fontWeight: FontWeight.normal,
  );
}
