import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/constants.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/ui_type/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'login_view_model.dart';

class LoginPage extends ViewModelWidget<LoginViewModel> {
  final Map<String, String> args;

  const LoginPage({super.key, required this.args});

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    final loginFormKey = GlobalKey<FormBuilderState>();
    final signUpFormKey = GlobalKey<FormBuilderState>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: FormBuilder(
          key: viewModel.isOnLoginForm ? loginFormKey : signUpFormKey,
          child: Container(
            width: MediaQuery.of(context).size.width > 400 ? 400 : null,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(color: AppColors.cyan, spreadRadius: 0.1, blurRadius: 16.0),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(viewModel.isOnLoginForm ? 'Login' : 'Sign Up', style: Constants.mediumHeadTextStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: _buildInputFields(viewModel.isOnLoginForm),
                  ),
                ),
                ..._buildButtons(viewModel, context, signUpFormKey, loginFormKey)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder() {
    return getIt.get<LoginViewModel>(param1: args);
  }

  List<Widget> _buildInputFields(bool isLoggingIn) {
    if (isLoggingIn) {
      return [
        TextInputWidget(
          label: 'Username',
          placeholder: 'Username',
          mandatory: true,
          onChange: (value) {},
          iconData: Icons.person,
        ),
        TextInputWidget(
          label: 'Password',
          placeholder: 'Password',
          mandatory: true,
          obscureText: true,
          onChange: (value) {},
          iconData: Icons.security,
        ),
      ];
    } else {
      return [
        Row(
          children: [
            Expanded(
              child: TextInputWidget(
                label: 'Name',
                placeholder: 'Name',
                mandatory: true,
                onChange: (value) {},
              ),
            ),
            Constants.mediumSizedBox,
            Expanded(
              child: TextInputWidget(
                label: 'Last Name',
                placeholder: 'Last Name',
                mandatory: true,
                onChange: (value) {},
              ),
            ),
          ],
        ),
        Constants.mediumSizedBox,
        Row(
          children: [
            Expanded(
              child: TextInputWidget(
                label: 'Email',
                placeholder: 'Email',
                mandatory: true,
                onChange: (value) {},
                inputType: 'Email',
              ),
            ),
            Constants.mediumSizedBox,
            Expanded(
              child: TextInputWidget(
                label: 'Phone',
                placeholder: 'Phone',
                mandatory: true,
                onChange: (value) {},
                inputType: 'Phone Number',
              ),
            ),
          ],
        ),
        Constants.mediumSizedBox,
        TextInputWidget(
          label: 'Username',
          placeholder: 'Username',
          mandatory: true,
          onChange: (value) {},
        ),
        Constants.mediumSizedBox,
        Row(
          children: [
            Expanded(
              child: TextInputWidget(
                label: 'Password',
                placeholder: 'Password',
                obscureText: true,
                mandatory: true,
                onChange: (value) {},
              ),
            ),
            Constants.mediumSizedBox,
            Expanded(
              child: TextInputWidget(
                label: 'Retype Password',
                placeholder: 'Retype Password',
                obscureText: true,
                mandatory: true,
                onChange: (value) {},
              ),
            ),
          ],
        ),
      ];
    }
  }

  List<Widget> _buildButtons(
      LoginViewModel viewModel, BuildContext context, GlobalKey<FormBuilderState> signUpFormKey, GlobalKey<FormBuilderState> loginFormKey) {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ElevatedButton(
          onPressed: () async {
            viewModel.isOnLoginForm ? loginFormKey.currentState?.save() : signUpFormKey.currentState?.save();
            if (viewModel.isOnLoginForm) {
              if (loginFormKey.currentState!.validate()) {
                await viewModel.login(
                    loginFormKey.currentState?.fields['Username']?.value, loginFormKey.currentState?.fields['Password']?.value, context);
              }
            } else {
              if (signUpFormKey.currentState!.validate()) {
                await viewModel.signUp(signUpFormKey.currentState!.value, context);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkCyan,
            shadowColor: AppColors.cyan,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.isOnLoginForm ? 'Login' : 'Sign Up',
                style: Constants.smallHeadTextStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Wrap(
          children: [
            viewModel.isOnLoginForm
                ? const Text('Don\'t have an account?  ', style: Constants.smallTextStyle)
                : const Text('Have an account?  ', style: Constants.smallTextStyle),
            TextButton(
              style: Constants.clearButtonStyle,
              onPressed: () {
                viewModel.setForm = !viewModel.isOnLoginForm;
              },
              child: viewModel.isOnLoginForm
                  ? const Text('Sign Up', style: Constants.smallHeadTextStyle)
                  : const Text('Login', style: Constants.smallHeadTextStyle),
            ),
          ],
        ),
      )
    ];
  }
}
