import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/ui_type/text_field_widget.dart';
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
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: FormBuilder(
          key: viewModel.isOnLoginForm ? loginFormKey : signUpFormKey,
          child: Container(
            margin: viewModel.isOnLoginForm ? const EdgeInsets.symmetric(horizontal: 24.0) : const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: const [
                BoxShadow(color: AppColors.cyan, spreadRadius: 1.0, blurRadius: 8.0),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(viewModel.isOnLoginForm ? Icons.login : Icons.person, color: AppColors.darkCyan, size: 80),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: _buildInputFields(viewModel.isOnLoginForm),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
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
                      padding: viewModel.isOnLoginForm
                          ? const EdgeInsets.symmetric(horizontal: 45.0, vertical: 12.0)
                          : const EdgeInsets.symmetric(horizontal: 94.0, vertical: 12.0),
                    ),
                    child: Text(
                      viewModel.isOnLoginForm ? 'Login' : 'Sign Up',
                      style: Dimens.headTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Wrap(
                    children: [
                      viewModel.isOnLoginForm
                          ? const Text('Don\'t have an account?  ', style: Dimens.smallTextStyle)
                          : const Text('Have an account?  ', style: Dimens.smallTextStyle),
                      TextButton(
                        style: Dimens.clearButtonStyle,
                        onPressed: () {
                          viewModel.setForm = !viewModel.isOnLoginForm;
                        },
                        child: viewModel.isOnLoginForm
                            ? const Text('Sign Up', style: Dimens.smallHeadTextStyle)
                            : const Text('Login', style: Dimens.smallHeadTextStyle),
                      ),
                    ],
                  ),
                ),
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
          hideLabel: true,
        ),
        TextInputWidget(
          label: 'Password',
          placeholder: 'Password',
          mandatory: true,
          obscureText: true,
          onChange: (value) {},
          hideLabel: true,
        ),
      ];
    } else {
      return [
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            TextInputWidget(
              width: 128,
              label: 'Name',
              placeholder: 'Name',
              mandatory: true,
              onChange: (value) {},
              hideLabel: true,
            ),
            TextInputWidget(
              width: 128,
              label: 'Last Name',
              placeholder: 'Last Name',
              mandatory: true,
              onChange: (value) {},
              hideLabel: true,
            ),
          ],
        ),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            TextInputWidget(
              width: 128,
              label: 'Email',
              placeholder: 'Email',
              mandatory: true,
              onChange: (value) {},
              hideLabel: true,
              inputType: 'Email',
            ),
            TextInputWidget(
              width: 128,
              label: 'Phone',
              placeholder: 'Phone',
              mandatory: true,
              onChange: (value) {},
              hideLabel: true,
              inputType: 'Phone Number',
            ),
          ],
        ),
        TextInputWidget(
          width: 272,
          label: 'Username',
          placeholder: 'Username',
          mandatory: true,
          onChange: (value) {},
          hideLabel: true,
        ),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            TextInputWidget(
              width: 128,
              label: 'Password',
              placeholder: 'Password',
              obscureText: true,
              mandatory: true,
              onChange: (value) {},
              hideLabel: true,
            ),
            TextInputWidget(
              width: 128,
              label: 'Retype Password',
              placeholder: 'Retype Password',
              obscureText: true,
              mandatory: true,
              onChange: (value) {},
              hideLabel: true,
            ),
          ],
        ),
      ];
    }
  }
}
