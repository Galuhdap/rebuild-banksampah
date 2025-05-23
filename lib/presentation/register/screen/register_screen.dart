import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/register/controllers/register_controller.dart';
import 'package:rebuild_bank_sampah/presentation/register/screen/detail_register_screen.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              // Kondisi yang diinginkan saat tombol back ditekan
              bool shouldNavigate = true; // Sesuaikan kondisinya

              if (shouldNavigate) {
                // Navigasi ke halaman home menggunakan Get.offAndToNamed
                Get.offAllNamed(AppRoutes.home);
                return false; // Mencegah pop langsung, kita kontrol manual navigasinya
              }
            },
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    //Get.put(RegisterController());
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
                body: RefreshIndicator(
                  onRefresh: () async {
                    controller.listUserRegister.clear();
                    controller.listRoleUser.clear();
                    await controller.getUser();
                    await controller.getRole();
                  },
                  child: Column(
                    children: [
                      SearchComponent(
                        controller: controller.searchRegisterUser,
                        onTap: () {},
                        onChanged: (value) {
                          controller.searchQuery.value = value;
                          // controller.filterSearchTrash();
                          controller.filterSearchTrash();
                        },
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Divider(
                            color: AppColors.colorNeutrals100,
                            thickness: 1,
                          ),
                          Obx(() {
                            return Row(
                              children: [
                                Flexible(
                                  child: MenuButtonWidget(
                                    label: AppConstants.ACTION_PENDING,
                                    onTap: () {
                                      // controller.searchOrderSeeAdmin.clear();
                                      controller.searchQuery.value = '';
                                      controller.setActiveButton(0);
                                    },
                                    isActive:
                                        controller.activeButtonIndex.value == 0,
                                  ),
                                ),
                                AppSizes.s30.width,
                                Flexible(
                                  child: MenuButtonWidget(
                                    label: AppConstants.ACTION_ACTIVE,
                                    onTap: () {
                                      // controller.searchOrderSeeAdmin.clear();
                                      controller.searchQuery.value = '';
                                      controller.setActiveButton(1);
                                    },
                                    isActive:
                                        controller.activeButtonIndex.value == 1,
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: AppSizes.s44);
                          })
                        ],
                      ),
                      Obx(
                        () {
                          List<UserData> filteredTrash =
                              controller.listUserRegister.where((order) {
                            if (controller.activeButtonIndex.value == 0) {
                              return order.status == 'INACTIVE';
                            } else if (controller.activeButtonIndex.value ==
                                1) {
                              return order.status == 'ACTIVE';
                            } else {
                              return order.status == 'CANCEL';
                            }
                          }).toList();
                          return controller.isLoadingUser.value
                              ? Center(
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Lottie.asset(
                                        Assets.lottie.loadingLogin),
                                  ),
                                )
                              : filteredTrash.isEmpty
                                  ? Container(
                                      padding: AppSizes.symmetricPadding(
                                          vertical: AppSizes.s150),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Assets.images.emptyData
                                                .image(scale: 4),
                                            Text(
                                              'Data Kosong',
                                              style: Get.textTheme.titleLarge!
                                                  .copyWith(
                                                      fontSize: AppSizes.s18),
                                            ),
                                            Text(
                                              'Tidak ada data yang bisa ditampilkan sekarang.',
                                              style: Get.textTheme.titleLarge!
                                                  .copyWith(
                                                      fontSize: AppSizes.s12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            controller.searchQuery.isNotEmpty
                                                ? controller
                                                    .searchUserRegister.length
                                                : filteredTrash.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data =
                                              controller.searchQuery.isNotEmpty
                                                  ? controller
                                                      .searchUserRegister[index]
                                                  : filteredTrash[index];
                                          return CardUserRegisterWidget(
                                            name: data.username,
                                            username: data.profile.telp,
                                            role: data.role.name,
                                            id: data.id,
                                            controller: controller,
                                            onTapEdit: () {
                                              
                                              Get.to(DetailRegisterScreen(
                                                data: data,
                                              ));
                                            },
                                          );
                                        },
                                      ),
                                    );
                        },
                      ),
                    ],
                  ).paddingSymmetric(
                    horizontal: AppSizes.s16,
                  ),
                )),
          );
        });
  }
}

class CardUserRegisterWidget extends StatelessWidget {
  final String name;
  final String username;
  final String role;
  final String id;
  final RegisterController controller;
  final VoidCallback onTapEdit;

  const CardUserRegisterWidget({
    super.key,
    required this.name,
    required this.username,
    required this.role,
    required this.id,
    required this.controller,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapEdit,
      // () {
      //   showModalBottom(
      //     context,
      //     Column(
      //       children: [
      //         AppSizes.s8.height,
      //         Center(
      //           child: Container(
      //             width: AppSizes.s56,
      //             height: AppSizes.s4,
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(AppSizes.s8),
      //                 color: AppColors.colorNeutrals800),
      //           ),
      //         ),
      //         AppSizes.s30.height,
      //         UDWidget(
      //           onTap: onTapEdit,
      //           name: AppConstants.LABEL_EDIT_PROFILE,
      //           icon: Icons.create_rounded,
      //         ),
      //         AppSizes.s30.height,
      //         UDWidget(
      //           onTap: () async {
                  // showDepositTrashSucces(
                  //     context: context,
                  //     icon: Assets.icons.phQuestion.path,
                  //     label: AppConstants.LABEL_DELETE_QUESTION,
                  //     firstButton: AppConstants.LABEL_NO,
                  //     fistOnPressed: () async {
                  //       Get.back();
                  //       Get.back();
                  //       //Get.toNamed(AppRoutes.priceTrash);
                  //     },
                  //     secondButton: AppConstants.LABEL_YES,
                  //     seccondOnPressed: () async {
                  //       // listTrash.clear();
                  //       // await getTrash();

                  //       await controller.deteleUserRegister(id);
                  //     },
                  //     showButton: true);
      //           },
      //           name: AppConstants.LABEL_DELETE,
      //           icon: Icons.delete,
      //         ),
      //       ],
      //     ),
      //   );
      // },
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
