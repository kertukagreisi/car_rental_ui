import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/constants.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/button_with_icon_widget.dart';
import 'package:car_rental_ui/widgets/cancel_button_widget.dart';
import 'package:car_rental_ui/widgets/save_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../widgets/ui_type/text_input_widget.dart';
import 'profile_view_model.dart';

class ProfilePage extends ViewModelWidget<ProfileViewModel> {
  const ProfilePage({super.key});

  @override
  Widget builder(BuildContext context, ProfileViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container(height: 80, color: AppColors.darkCyan)),
                      ],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  left: 0.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(border: Border.all(color: Colors.white), color: AppColors.darkCyan, shape: BoxShape.circle),
                          child: (viewModel.profilePicture?.length ?? 0) != 0
                              ? CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3), // Border radius
                                    child: ClipOval(child: Image.memory(viewModel.profilePicture!)),
                                  ),
                                )
                              : Center(child: Text('${viewModel.user.name!.isNotEmpty ? viewModel.user.name![0].toUpperCase() : ''}.${viewModel.user.lastName!.isNotEmpty ? viewModel.user.lastName![0].toUpperCase() : ''}', style: Constants.mediumTextStyle.copyWith(color: Colors.white, fontSize: 60.0))),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Constants.mediumSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${viewModel.user.name} ${viewModel.user.lastName}', style: Constants.headTextStyle),
                    Constants.smallSizedBox,
                    Text(viewModel.user.role!.value, style: Constants.mediumHeadTextStyle.copyWith(color: AppColors.gray)),
                  ],
                )
              ],
            ),
            Constants.mediumSizedBox,
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Icon(Icons.person, size: 20, color: AppColors.darkGray),
                      ),
                      Text(viewModel.user.username ?? '', style: Constants.largeTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Constants.mediumSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Icon(Icons.email, color: AppColors.darkGray, size: 20),
                      ),
                      Text(viewModel.user.email ?? '', style: Constants.largeTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Constants.mediumSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Icon(Icons.phone, color: AppColors.darkGray, size: 20),
                      ),
                      Text(viewModel.user.phone ?? '', style: Constants.largeTextStyle.copyWith(color: AppColors.darkCyan)),
                    ],
                  ),
                  Constants.largeSizedBox,
                  Row(
                    children: [
                      ButtonWithIcon(
                          text: 'Edit',
                          onPressed: () {
                            showDialog(context: context, builder: (BuildContext context) => _buildEditDialog(viewModel, context));
                          },
                          icon: Icons.edit,
                          dark: true),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog _buildEditDialog(ProfileViewModel viewModel, BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
                padding: Constants.mediumPadding,
                decoration: Constants.popUpHeaderDecoration,
                child: Text('Edit Profile', style: Constants.mediumHeadTextStyle.copyWith(color: Colors.white))),
          ),
        ],
      ),
      content: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: _buildInputFields(viewModel, context, formKey),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputFields(ProfileViewModel viewModel, BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return [
      TextInputWidget(
        initialValue: viewModel.user.username,
        label: 'Username',
        mandatory: true,
        onChange: (value) {},
        showLabel: true,
        iconData: Icons.email,
      ),
      Constants.mediumSizedBox,
      Row(
        children: [
          Expanded(
            child: TextInputWidget(
              initialValue: viewModel.user.name,
              label: 'Name',
              mandatory: true,
              onChange: (value) {},
              showLabel: true,
              iconData: Icons.person,
            ),
          ),
          Constants.mediumSizedBox,
          Expanded(
            child: TextInputWidget(
              initialValue: viewModel.user.lastName,
              label: 'Last Name',
              mandatory: true,
              onChange: (value) {},
              showLabel: true,
              iconData: Icons.person,
            ),
          ),
        ],
      ),
      Constants.mediumSizedBox,
      TextInputWidget(
        initialValue: viewModel.user.email,
        label: 'Email',
        mandatory: true,
        onChange: (value) {},
        showLabel: true,
        iconData: Icons.email,
      ),
      Constants.mediumSizedBox,
      TextInputWidget(
        initialValue: viewModel.user.phone,
        label: 'Phone',
        mandatory: true,
        onChange: (value) {},
        showLabel: true,
        iconData: Icons.phone,
      ),
      Constants.mediumSizedBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SaveButton(onPressed: () async {
            formKey.currentState?.save();
            if (formKey.currentState!.validate()) {
              await viewModel.updateProfile(formKey.currentState?.value);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          }),
          Constants.smallSizedBox,
          CancelButton(onPressed: () {
            Navigator.of(context).pop();
          })
        ],
      )
    ];
  }

  @override
  ProfileViewModel viewModelBuilder() {
    return getIt.get<ProfileViewModel>();
  }
}
