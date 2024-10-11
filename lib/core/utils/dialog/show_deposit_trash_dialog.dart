// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/trash_controller.dart';

void showDepositTrashDialog(BuildContext context, String label) {
  final controller = Get.put(TrashController());
  Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: AppSizes.symmetricPadding(
              horizontal: AppSizes.s24, vertical: AppSizes.s30),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(label, style: Get.textTheme.labelLarge),
                ),
                SizedBox(
                  height: 10,
                ),
                AppSizes.s20.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputWidget(
                      label: AppConstants.LABEL_NAME_TRASH,
                      hintText: AppConstants.LABEL_NAME_TRASH,
                      controller: controller.nameController,
                      textInputType: TextInputType.name,
                      hintStyle: Get.textTheme.titleMedium!.copyWith(
                          color: AppColors.colorSecondary600,
                          fontSize: AppSizes.s12),
                    ),
                    AppSizes.s20.height,
                    InputWidget(
                      label: AppConstants.LABEL_WEIGHT_TRASH,
                      hintText: AppConstants.LABEL_WEIGHT_TRASH,
                      controller: controller.weightController,
                      textInputType: TextInputType.name,
                      hintStyle: Get.textTheme.titleMedium!.copyWith(
                          color: AppColors.colorSecondary600,
                          fontSize: AppSizes.s12),
                    ),
                    AppSizes.s20.height,
                    InputWidget(
                      label: AppConstants.LABEL_PRICEs_TRASH,
                      hintText: AppConstants.LABEL_PRICEs_TRASH,
                      controller: controller.priceController,
                      textInputType: TextInputType.name,
                      hintStyle: Get.textTheme.titleMedium!.copyWith(
                          color: AppColors.colorSecondary600,
                          fontSize: AppSizes.s12),
                    ),
                    AppSizes.s20.height,
                    Row(
                      children: [
                        Flexible(
                          child: Button.outlined(
                            onPressed: () {
                              Get.back();
                            },
                            label: AppConstants.ACTION_CLOSE,
                          ),
                        ),
                        AppSizes.s10.width,
                        Obx(() {
                          return controller.isloadingAddTrash.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Flexible(
                                  child: Button.filled(
                                    onPressed: () async {
                                      await controller
                                          .postDepositTrash(context);
                                      // showDepositTrashSucces(
                                      //     context: context,
                                      //     icon: Assets.icons.succes.path,
                                      //     label:
                                      //         AppConstants.LABEL_DEPOSIT_TRASH_SUCCES,
                                      //     firstButton: AppConstants.LABEL_SEE_HISTORY,
                                      //     fistOnPressed: () {
                                      //       Get.back();
                                      //       Get.back();
                                      //     },
                                      //     secondButton: AppConstants.LABEL_BERANDA,
                                      //     seccondOnPressed: () {
                                      //       Get.offAllNamed(AppRoutes.home);
                                      //     },
                                      //     showButton: true);
                                    },
                                    label: 'Tambah',
                                  ),
                                );
                        })
                      ],
                    )
                  ],
                ),
              ]),
        ),
      ));
}

class InputControllerTrash {
  TextEditingController kode_nasabah;
  TextEditingController price;
  TextEditingController type_trash;
  TextEditingController weight;

  InputControllerTrash(
      {required this.kode_nasabah,
      required this.price,
      required this.type_trash,
      required this.weight});
}

Future<dynamic> showModalBottom(BuildContext context, Widget widget) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
            top: 8,
          ),
          child: widget,
        );
      });
}
