import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/helpers/validation_helper.dart';
import 'package:rebuild_bank_sampah/presentation/login/controllers/login_controller.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            body: ListView(
              padding: AppSizes.symmetricPadding(
                  horizontal: AppSizes.s23, vertical: AppSizes.s125),
              children: [
                Assets.images.logobs.image(scale: 3),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputWidget(
                        label: AppConstants.LABEL_EMAIL,
                        hintText: AppConstants.HINT_EMAIL,
                        controller: controller.usernameController,
                        textInputType: TextInputType.name,
                        validator: emptyValidation,
                      ),
                      AppSizes.s20.height,
                      InputWidget(
                        label: AppConstants.LABEL_PASSWORD,
                        hintText: AppConstants.HINT_PASSWORD,
                        controller: controller.passwordController,
                        textInputType: TextInputType.name,
                        validator: emptyValidation,
                        isObscure: true,
                        suffixIcon: true,
                      ),
                    ],
                  ),
                ),
                AppSizes.s20.height,
                Button.filled(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.userLogin();
                      }
                    },
                    label: AppConstants.ACTION_LOGIN),
                AppSizes.s20.height,
                Center(
                  child: Text(
                    AppConstants.HINT_ATAU,
                    style: Get.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.colorNeutrals700),
                  ),
                ),
                AppSizes.s20.height,
                Button.outlined(
                    onPressed: () {}, label: AppConstants.ACTION_REGISTER),
              ],
            ),
          );
        });
  }
}
