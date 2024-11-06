import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/helpers/validation_helper.dart';
import 'package:rebuild_bank_sampah/presentation/login/controllers/login_controller.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

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
                  horizontal: AppSizes.s24, vertical: AppSizes.s125),
              children: [
                Center(
                  child: Assets.images.logoBs.image(scale: 4),
                ),
                AppSizes.s40.height,
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputWidget(
                        label: AppConstants.LABEL_USERNAME,
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
                AppSizes.s10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.forgotPassword);
                      },
                      child: Text(
                        'Lupa Password ?',
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s12,
                            color: AppColors.colorBasePrimary),
                      ),
                    ),
                  ],
                ),
                AppSizes.s20.height,
                Obx(() {
                  return controller.isloadingLogin.value
                      ? Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Lottie.asset(Assets.lottie.loadingLogin),
                          ),
                        )
                      : Button.filled(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.userLogin();
                            }
                          },
                          label: AppConstants.ACTION_LOGIN);
                }),
                AppSizes.s10.height,
                Button.outlined(
                    onPressed: () {
                      // if (controller.formKey.currentState!.validate()) {
                      //   controller.userLogin();
                      // }
                      Get.toNamed(AppRoutes.registerCustomer);
                    },
                    label: AppConstants.ACTION_REGISTER),
                AppSizes.s20.height,
              ],
            ),
          );
        });
  }
}
