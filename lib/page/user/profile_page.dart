import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/constants.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import 'profile_view_model.dart';

class ProfilePage extends ViewModelWidget<ProfileViewModel> {
  const ProfilePage({super.key});

  @override
  Widget builder(BuildContext context, ProfileViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Wrap(
                spacing: 24.0,
                runSpacing: 32.0,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Name', style: Constants.mediumHeadTextStyle),
                      ),
                      Text(viewModel.user.name ?? '', style: Constants.mediumTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Last Name', style: Constants.mediumHeadTextStyle),
                      ),
                      Text(viewModel.user.lastName ?? '', style: Constants.mediumTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Email', style: Constants.mediumHeadTextStyle),
                      ),
                      Text(viewModel.user.email ?? '', style: Constants.mediumTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Phone Number', style: Constants.mediumHeadTextStyle),
                      ),
                      Text(viewModel.user.phone ?? '', style: Constants.mediumTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Username', style: Constants.mediumHeadTextStyle),
                      ),
                      Text(viewModel.user.username ?? '', style: Constants.mediumTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Role', style: Constants.mediumHeadTextStyle),
                      ),
                      Text(viewModel.user.role?.value ?? '', style: Constants.mediumTextStyle.copyWith(color: AppColors.darkCyan)),
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
  ProfileViewModel viewModelBuilder() {
    return getIt.get<ProfileViewModel>();
  }
}
