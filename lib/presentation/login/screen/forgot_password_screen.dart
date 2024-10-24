import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/helpers/validation_helper.dart';
import 'package:rebuild_bank_sampah/presentation/login/controllers/login_controller.dart';
import 'package:rebuild_bank_sampah/presentation/login/screen/loading_forgot_password_screen.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      bottomNavigationBar: Container(
        padding: AppSizes.symmetricPadding(
            vertical: AppSizes.s16, horizontal: AppSizes.s16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.colorBaseBlack.withOpacity(0.08),
            ),
          ],
        ),
        child: Button.filled(
          onPressed: () async {
            // Get.to(LoadingRegisterScreen(
            //   status: controller.isLoadingAddUser.value,
            //   label: AppConstants.LABEL_REGISTER_SUCCES,
            // ));
            Get.to(LoadingForgotPasswordScreen(
              label: 'Password Telah Di Ubah',
            ));
            await controller.forgotPassword();
            // if (controller.formKey.currentState!.validate()) {

            // }
          },
          label: "Ubah Password",
        ),
      ),
      appBar: AppBar(
        title: Text(
          AppConstants.LABEL_FORGOT_PASS,
          style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.colorBaseBlack,
          ),
        ),
      ),
      body: Column(
        children: [
          InputWidget(
            label: AppConstants.LABEL_NAME,
            hintText: AppConstants.HINT_NAME,
            controller: controller.userController,
            textInputType: TextInputType.name,
            validator: emptyValidation,
          ),
          AppSizes.s20.height,
          InputWidget(
            label: AppConstants.LABEL_NEW_PASSWORD,
            hintText: AppConstants.HINT_PASSWORD_NEW,
            controller: controller.newPasswordController,
            textInputType: TextInputType.name,
            validator: emptyValidation,
            isObscure: true,
            suffixIcon: true,
          ),
        ],
      ).paddingSymmetric(horizontal: AppSizes.s20),
    );
  }
}
