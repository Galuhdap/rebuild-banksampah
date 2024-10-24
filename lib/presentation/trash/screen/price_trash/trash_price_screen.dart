import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/update_delete_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/trash_controller.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/price_trash/edit_price_trash_screen.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class TrashPriceScreen extends StatelessWidget {
  const TrashPriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrashController>(
      init: TrashController(),
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
                  controller.nameController.text = '';
                  controller.priceController.text = '';
                  controller.weightController.text = '';
                  Get.toNamed(AppRoutes.addTrashSuper);
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
                  'Harga Sampah',
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontSize: AppSizes.s18),
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.home);
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
                    controller: controller.searchTrash,
                    onTap: () {},
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                      controller.filterSearchTrash();
                    },
                  ),
                  Obx(
                    () {
                      return controller.isloadingTrash.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.listTrash.isEmpty
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
                                        ? controller.searchListTrash.length
                                        : controller.listTrash.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var data = controller
                                              .searchQuery.isNotEmpty
                                          ? controller.searchListTrash[index]
                                          : controller.listTrash[index];
                                      return PriceTrashWidget(
                                        name: data.nama,
                                        price: data.harga.currencyFormatRp,
                                        controller: controller,
                                        id: data.id,
                                        ontap: () async {
                                          Get.to(EditPriceTrashScreen(
                                            data: data,
                                            id: data.id,
                                          ));
                                        },
                                      );
                                    },
                                  ),
                                );
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: AppSizes.s16)),
        );
      },
    );
  }
}

class PriceTrashWidget extends StatelessWidget {
  final String name;
  final String price;
  final String id;
  final TrashController controller;
  final VoidCallback ontap;

  const PriceTrashWidget(
      {super.key,
      required this.name,
      required this.price,
      required this.controller,
      required this.id,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottom(
          context,
          Column(
            children: [
              AppSizes.s8.height,
              Center(
                child: Container(
                  width: AppSizes.s56,
                  height: AppSizes.s4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s8),
                      color: AppColors.colorNeutrals800),
                ),
              ),
              AppSizes.s30.height,
              UDWidget(
                onTap: ontap,
                name: AppConstants.LABEL_EDIT_PROFILE,
                icon: Icons.create_rounded,
              ),
              AppSizes.s30.height,
              UDWidget(
                onTap: () async {
                  showDepositTrashSucces(
                      context: context,
                      icon: Assets.icons.phQuestion.path,
                      label: AppConstants.LABEL_DELETE_QUESTION,
                      firstButton: AppConstants.LABEL_NO,
                      fistOnPressed: () async {
                        Get.back();
                        Get.back();
                        //Get.toNamed(AppRoutes.priceTrash);
                      },
                      secondButton: AppConstants.LABEL_YES,
                      seccondOnPressed: () async {
                        // listTrash.clear();
                        // await getTrash();

                        await controller.deletePriceTrash(id, context);
                      },
                      showButton: true);
                  // await controller.deletePriceTrash(id, context);
                },
                name: AppConstants.LABEL_DELETE,
                icon: Icons.delete,
              ),
              // Obx(
              //   () {
              //     return controller.isloadingDeletePriceTrash.value
              //         ? Center(
              //             child: CircularProgressIndicator(),
              //           )
              //         : UDWidget(
              //             onTap: () async {
              //               await controller.deletePriceTrash(id, context);
              //             },
              //             name: AppConstants.LABEL_DELETE,
              //             icon: Icons.delete,
              //           );
              //   },
              // ),
            ],
          ),
        );
      },
      child: Container(
        padding: AppSizes.symmetricPadding(
            horizontal: AppSizes.s12, vertical: AppSizes.s13),
        margin: AppSizes.onlyPadding(
          bottom: AppSizes.s12,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s10),
            border: Border.all(
              color: AppColors.colorNeutrals100,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
            ),
            Text(
              '${price}/Kg',
              style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: AppSizes.s16, color: AppColors.colorPrimary800),
            ),
          ],
        ),
      ),
    );
  }
}
