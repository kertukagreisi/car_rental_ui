import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import 'user_view_model.dart';

class UserPage extends ViewModelWidget<UserViewModel> {
  const UserPage({super.key});

  @override
  Widget builder(BuildContext context, UserViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Username', style: Dimens.mediumHeadTextStyle),
                        Text(viewModel.user.username ?? '', style: Dimens.mediumTextStyle.copyWith(color: AppColors.darkGray)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Role', style: Dimens.mediumHeadTextStyle),
                      Text(viewModel.user.role?.value ?? '', style: Dimens.mediumTextStyle.copyWith(color: AppColors.darkGray)),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Wrap(
                direction: Axis.vertical,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  UserViewModel viewModelBuilder() {
    return getIt.get<UserViewModel>();
  }
}
