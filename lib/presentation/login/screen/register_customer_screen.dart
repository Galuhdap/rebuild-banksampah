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
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class RegisterCustomerScreen extends StatelessWidget {
  const RegisterCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //RegisterController controller = Get.put(RegisterController());
    LoginController controller = Get.put(LoginController());
    return WillPopScope(
      onWillPop: () async {
        bool shouldNavigate = true; // Sesuaikan kondisinya

        if (shouldNavigate) {
          // Navigasi ke halaman home menggunakan Get.offAndToNamed
          Get.offAllNamed(AppRoutes.register);
          return false; // Mencegah pop langsung, kita kontrol manual navigasinya
        }
      },
      child: Scaffold(
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
             await controller.postRegister(context);
              // if (controller.formKey.currentState!.validate()) {

              // }
            },
            label: "Tambah User",
          ),
        ),
        appBar: AppBar(
          title: Text(
            AppConstants.LABEL_ADD_REGISTER_USER,
            style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
          ),
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.register);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.colorBaseBlack,
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.colorBaseWhite, width: AppSizes.s2),
                borderRadius: BorderRadius.circular(100),
                // color: AppColors.colorBasePrimary,
                image: DecorationImage(
                  image: AssetImage(Assets.images.avatarSuperAdmin.path),
                ),
              ),
            ),
            Column(
              children: [
                AppSizes.s20.height,
                InputWidget(
                  label: AppConstants.LABEL_NAME,
                  hintText: AppConstants.HINT_NAME,
                  controller: controller.nameController,
                  textInputType: TextInputType.name,
                  validator: emptyValidation,
                ),
                AppSizes.s20.height,
                InputWidget(
                  label: AppConstants.LABEL_NOKTP,
                  hintText: AppConstants.HINT_NO_KTP,
                  controller: controller.noKtpController,
                  textInputType: TextInputType.number,
                  validator: emptyValidation,
                ),
                AppSizes.s20.height,
                InputWidget(
                  label: AppConstants.LABEL_ADDRESS,
                  hintText: AppConstants.HINT_ALAMAT,
                  controller: controller.alamatController,
                  textInputType: TextInputType.name,
                  validator: emptyValidation,
                ),
                AppSizes.s20.height,
                InputWidget(
                  label: AppConstants.LABEL_PHONE_NUMBER,
                  hintText: AppConstants.HINT_PHONE_NUMBER,
                  controller: controller.telpController,
                  textInputType: TextInputType.number,
                  validator: emptyValidation,
                ),
                AppSizes.s20.height,
                InputWidget(
                  label: AppConstants.LABEL_USERNAME,
                  hintText: AppConstants.HINT_EMAIL,
                  controller: controller.usernamesController,
                  textInputType: TextInputType.name,
                  validator: emptyValidation,
                ),
                AppSizes.s20.height,
                InputWidget(
                  label: AppConstants.LABEL_PASSWORD,
                  hintText: AppConstants.HINT_PASSWORD,
                  controller: controller.passwordsController,
                  textInputType: TextInputType.name,
                  validator: emptyValidation,
                  isObscure: true,
                  suffixIcon: true,
                ),
              ],
            ).paddingSymmetric(horizontal: AppSizes.s24, vertical: AppSizes.s44)
            // Form(
            //     key: controller.formKey,
            //     child: )
          ],
        ),
      ),
    );
  }
}
