import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/helpers/validation_helper.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/register/controllers/register_controller.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/register_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';

class EditRegisterScreen extends StatelessWidget {
  final UserData datas;
  const EditRegisterScreen({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());
    final TextEditingController nameController =
        TextEditingController(text: datas.profile.name);
    final TextEditingController usernameController =
        TextEditingController(text: datas.username);
    // final TextEditingController noKtpController = TextEditingController(text: datas.);
    final TextEditingController alamatController =
        TextEditingController(text: datas.profile.address);
    final TextEditingController telpController =
        TextEditingController(text: datas.profile.telp);
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
            final data = RegisterRequest(
              username: usernameController.text,
              name: nameController.text,
              address: alamatController.text,
              //role: dropdownSearchFieldController.text,
              telp: telpController.text,
            );

            await controller.editRegister(data, datas.id);
            // if (controller.formKey.currentState!.validate()) {

            // }
          },
          label: "Edit User",
        ),
      ),
      appBar: AppBar(
        title: Text(
          AppConstants.LABEL_EDIT_REGISTER_USER,
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
                label: AppConstants.LABEL_USERNAME,
                hintText: AppConstants.HINT_EMAIL,
                controller: usernameController,
                textInputType: TextInputType.name,
                validator: emptyValidation,
              ),
              AppSizes.s20.height,
              InputWidget(
                label: AppConstants.LABEL_NAME,
                hintText: AppConstants.HINT_NAME,
                controller: nameController,
                textInputType: TextInputType.name,
                validator: emptyValidation,
              ),
              AppSizes.s20.height,
              InputWidget(
                label: AppConstants.LABEL_ADDRESS,
                hintText: AppConstants.HINT_ALAMAT,
                controller: alamatController,
                textInputType: TextInputType.name,
                validator: emptyValidation,
              ),
              AppSizes.s20.height,
              InputWidget(
                label: AppConstants.LABEL_PHONE_NUMBER,
                hintText: AppConstants.HINT_PHONE_NUMBER,
                controller: telpController,
                textInputType: TextInputType.number,
                validator: emptyValidation,
              ),
              AppSizes.s20.height,
            ],
          ).paddingSymmetric(horizontal: AppSizes.s24, vertical: AppSizes.s44)
          // Form(
          //     key: controller.formKey,
          //     child: )
        ],
      ),
    );
  }
}
