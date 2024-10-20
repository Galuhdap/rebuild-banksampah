import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/register/controllers/register_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                 // Get.put(RegisterController());
                  Get.toNamed(AppRoutes.addRegister);
                },
                backgroundColor: AppColors.colorBasePrimary,
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: AppSizes.s35,
                ),
              ),
              appBar: AppBar(
                title: Text(
                  AppConstants.LABEL_REGISTER_USER,
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontSize: AppSizes.s18),
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.offAndToNamed(AppRoutes.home);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
              ),
              body: Column(
                children: [
                  SearchComponent(
                    controller: controller.searchRegisterUser,
                    onTap: () {},
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                      controller.filterSearchTrash();
                    },
                  ),
                  Obx(
                    () {
                      return controller.isLoadingUser.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.listUserRegister.isEmpty
                              ? Container(
                                  padding: AppSizes.symmetricPadding(
                                      vertical: AppSizes.s150),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Assets.images.emptyData.image(scale: 4),
                                        Text(
                                          'Data Kosong',
                                          style: Get.textTheme.titleLarge!
                                              .copyWith(fontSize: AppSizes.s18),
                                        ),
                                        Text(
                                          'Tidak ada data yang bisa ditampilkan sekarang.',
                                          style: Get.textTheme.titleLarge!
                                              .copyWith(
                                                  fontSize: AppSizes.s12,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: controller.searchQuery.isNotEmpty
                                        ? controller.searchUserRegister.length
                                        : controller.listUserRegister.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var data = controller
                                              .searchQuery.isNotEmpty
                                          ? controller.searchUserRegister[index]
                                          : controller.listUserRegister[index];
                                      return CardUserRegisterWidget(
                                        name: data.username,
                                        username: data.username,
                                        role: data.role.name,
                                        id: data.id,
                                        controller: controller,
                                      );
                                    },
                                  ),
                                );
                    },
                  ),
                ],
              ).paddingSymmetric(
                horizontal: AppSizes.s16,
              ));
        });
  }
}

class CardUserRegisterWidget extends StatelessWidget {
  final String name;
  final String username;
  final String role;
  final String id;
  final RegisterController controller;

  const CardUserRegisterWidget({
    super.key,
    required this.name,
    required this.username,
    required this.role,
    required this.id,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // showModalBottom(
        //   context,
        //   Column(
        //     children: [
        //       AppSizes.s8.height,
        //       Center(
        //         child: Container(
        //           width: AppSizes.s56,
        //           height: AppSizes.s4,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(AppSizes.s8),
        //               color: AppColors.colorNeutrals800),
        //         ),
        //       ),
        //       // AppSizes.s30.height,
        //       // UDWidget(
        //       //   onTap: () async {
        //       //     // await controller
        //       //     //     .deleteDepositTrash(
        //       //     //         data.id,
        //       //     //         context);
        //       //     //     showDepositTrashDialog(
        //       //     //         context,
        //       //     //         AppConstants
        //       //     //             .LABEL_EDIT_DEPOSIT_TRASH);
        //       //   },
        //       //   name: AppConstants.LABEL_EDIT_PROFILE,
        //       //   icon: Icons.create_rounded,
        //       // ),
        //       AppSizes.s30.height,
        //       Obx(
        //         () {
        //           return controller.isLoadingDeleteUser.value
        //               ? Center(
        //                   child: CircularProgressIndicator(),
        //                 )
        //               : UDWidget(
        //                   onTap: () async {
        //                     //await controller.deletePriceTrash(id, context);
        //                   },
        //                   name: AppConstants.LABEL_DELETE,
        //                   icon: Icons.delete,
        //                 );
        //         },
        //       ),
        //     ],
        //   ),
        // );
      },
      child: Container(
        padding: AppSizes.allPadding(AppSizes.s16),
        margin: AppSizes.onlyPadding(
          bottom: AppSizes.s12,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s10),
            border: Border.all(
              color: AppColors.colorNeutrals100,
            )),
        child: Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: AppColors.colorPrimary300,
                  size: AppSizes.s50,
                ),
              ],
            ),
            AppSizes.s10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontSize: AppSizes.s16),
                ),
                AppSizes.s8.height,
                Text(
                  username,
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.s14, fontWeight: FontWeight.w300),
                ),
                AppSizes.s5.height,
                Text(
                  'Role : ${role}',
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.s14, fontWeight: FontWeight.w300),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
