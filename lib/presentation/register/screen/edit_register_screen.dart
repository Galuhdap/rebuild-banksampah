import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/helpers/validation_helper.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/profile/widget/no_profile_widget.dart';
import 'package:rebuild_bank_sampah/presentation/register/controllers/register_controller.dart';
import 'package:rebuild_bank_sampah/presentation/register/screen/loading_register_screen.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_role_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';

class EditRegisterScreen extends StatelessWidget {
  final UserData datas;
  const EditRegisterScreen({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.find();
    final TextEditingController nameController =
        TextEditingController(text: datas.profile.name);
    // final TextEditingController noKtpController = TextEditingController(text: datas.);
    final TextEditingController alamatController =
        TextEditingController(text: datas.profile.name);
    final TextEditingController telpController = TextEditingController();
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
            Get.to(LoadingRegisterScreen(
              status: controller.isLoadingAddUser.value,
              label: AppConstants.LABEL_REGISTER_SUCCES,
            ));
            await controller.postDepositTrash(context);
            // if (controller.formKey.currentState!.validate()) {

            // }
          },
          label: "Editxs User",
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
          NoProfileWidget(
            onTap: () {},
          ),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Role',
                    style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12,
                    ),
                  ),
                  AppSizes.s10.height,
                  DropDownSearchFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        hintText: 'Pilih Role',
                        suffixIcon: Icon(Iconsax.arrow_down_1),
                        hintStyle: Get.textTheme.titleMedium!.copyWith(
                            color: AppColors.colorSecondary600,
                            fontSize: AppSizes.s15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.s10),
                          borderSide: BorderSide(
                            color: AppColors.colorSecondary400,
                            width: AppSizes.s1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.s10),
                          borderSide: BorderSide(
                              color: AppColors.colorSecondary400,
                              width: AppSizes.s2),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: AppSizes.s16,
                        color: Colors.black,
                      ),
                      controller: controller.dropdownSearchFieldController,
                    ),
                    suggestionsCallback: (pattern) {
                      return controller.getSuggestions(pattern);
                    },
                    itemBuilder: (context, RoleData suggestion) {
                      return ListTile(
                        title: Text(
                          suggestion.name,
                          style: TextStyle(
                            fontSize: AppSizes.s16,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    itemSeparatorBuilder: (context, index) {
                      return const Divider();
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (RoleData suggestion) {
                      controller.dropdownSearchFieldController.text =
                          suggestion.name;
                      //controller.selectedCustomerId.value = suggestion.id;
                    },
                    suggestionsBoxController:
                        controller.suggestionBoxController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a customer' : null,
                    onSaved: (value) {},
                    displayAllSuggestionWhenTap: true,
                  ),
                ],
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
              // InputWidget(
              //   label: AppConstants.LABEL_NOKTP,
              //   hintText: AppConstants.HINT_NO_KTP,
              //   controller: noKtpController,
              //   textInputType: TextInputType.number,
              //   validator: emptyValidation,
              // ),
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
