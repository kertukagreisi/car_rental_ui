import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'fonts.dart';

class Constants {
  const Constants._();

  static const tableCellPadding = EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0);
  static const buttonPadding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
  static const smallPadding = EdgeInsets.all(8.0);
  static const mediumPadding = EdgeInsets.all(16);
  static const largePadding = EdgeInsets.all(24);

  static const extraSmallSvgPictureSize = 16.0;
  static const smallSizedBox = SizedBox(width: 4, height: 4);
  static const mediumSizedBox = SizedBox(width: 8, height: 8);
  static const largeSizedBox = SizedBox(width: 24, height: 24);
  static const smallBorderRadius = 4.0;
  static const defaultElevation = 8.0;
  static const defaultScrollbarThickness = 8.0;
  static const filterButtonHeight = 56.0;
  static const filterButtonWidth = 150.0;
  static const filePickerHeightNoFiles = 66.0;
  static const filePickerHeightFiles = 110.0;

  static ButtonStyle clearButtonStyle = TextButton.styleFrom(
    minimumSize: Size.zero,
    padding: EdgeInsets.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  static ButtonStyle saveButtonStyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      backgroundColor: AppColors.darkCyan,
      side: const BorderSide(color: AppColors.darkCyan, width: 1.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)));

  static ButtonStyle cancelButtonStyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      backgroundColor: Colors.white,
      side: const BorderSide(color: AppColors.darkCyan, width: 1.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)));

  static ButtonStyle darkIconButtonStyle = IconButton.styleFrom(
  backgroundColor: AppColors.darkCyan,
  padding: const EdgeInsets.all(0.0),
  side: const BorderSide(color: AppColors.darkCyan, width: 1.2),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );

  static ButtonStyle lightIconButtonStyle= IconButton.styleFrom(
    backgroundColor: Colors.white,
    padding: const EdgeInsets.all(0),
    side: const BorderSide(color: AppColors.darkCyan, width: 1.2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );

  static const headTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 24,
    fontFamily: Fonts.openSansHead,
    fontWeight: FontWeight.bold,
  );

  static const screenTitleStyle = TextStyle(
    color: AppColors.lightGray,
    fontSize: 24,
    fontFamily: Fonts.openSansHead,
  );

  static const extraSmallHeadTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 12,
    fontFamily: Fonts.openSansHead,
    fontWeight: FontWeight.bold,
  );

  static const smallHeadTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 14,
    fontFamily: Fonts.openSansHead,
    fontWeight: FontWeight.bold,
  );

  static const mediumHeadTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 16,
    fontFamily: Fonts.openSansHead,
    fontWeight: FontWeight.bold,
  );

  static const mediumTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 16,
    fontFamily: Fonts.openSans,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.01 * 16,
  );

  static const smallTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 14,
    fontFamily: Fonts.openSans,
    fontWeight: FontWeight.normal,
  );

  static const extraSmallTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 12,
    fontFamily: Fonts.openSans,
    fontWeight: FontWeight.normal,
  );

  static const titleTextStyle = TextStyle(
    color: AppColors.darkCyan,
    fontSize: 18,
    fontFamily: Fonts.openSansHead,
    fontWeight: FontWeight.normal,
  );
}