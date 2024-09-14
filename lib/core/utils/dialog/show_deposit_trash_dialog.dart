import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/config/theme_config.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/deposit_trash_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';

void showDepositTrashDialog(BuildContext context, String label) {
  final controller = Get.put(DepositTrashController());
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
            InputWidget(
              label: AppConstants.LABEL_KODE_NASABAH,
              hintText: AppConstants.LABEL_KODE_NASABAH,
              controller: controller.kode_nasabah,
              textInputType: TextInputType.name,
              hintStyle: Get.textTheme.titleMedium!.copyWith(
                  color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
            ),
            AppSizes.s20.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.LABEL_TYPE_TRASH,
                  style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s12,
                  ),
                ),
                AppSizes.s10.height,
                Obx(() {
                  return Container(
                      padding: AppSizes.symmetricPadding(
                          vertical: AppSizes.s5, horizontal: AppSizes.s15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s10),
                          border: Border.all(
                              color: AppColors.colorSecondary400,
                              width: AppSizes.s1)),
                      child: DropdownButton<String>(
                        value: controller.selectedTrashId.value,
                        menuMaxHeight: AppSizes.setResponsiveWidth(context),
                        underline: SizedBox.shrink(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          weight: AppSizes.s20,
                          size: AppSizes.s30,
                          color: ThemeConfig.neutral0,
                        ),
                        iconSize: AppSizes.s24,
                        elevation: 2,
                        isExpanded: true,
                        style: ThemeConfig.labelMedium
                            .copyWith(color: Colors.black),
                        items: controller.listTrash
                            .map<DropdownMenuItem<String>>((GroupTrash trash) {
                          return DropdownMenuItem<String>(
                            value: trash.id,
                            child: Text(trash.nama),
                          );
                        }).toList(),
                        onChanged: (Object? value) {
                          if (value != null && value is String) {
                            controller.setDropdownValue(value);
                            // var selectedTrash = controller.listTrash.firstWhere(
                            //   (trash) => trash.id == value,
                            // );

                            // if (selectedTrash != null) {
                            //   int harga = selectedTrash.harga;
                            //   print("Harga: $harga");
                            //   // Simpan atau gunakan harga sesuai kebutuhan
                            // }
                            controller.setPriceTrashValue(value);

                            // controller.getCommodityChartDaily();
                          }
                        },
                      ));
                }),
              ],
            ),
            AppSizes.s20.height,
            Obx(
              () {
                return InputWidget(
                  label: AppConstants.LABEL_PRICE,
                  hintText: controller.priceTrash.value.toString(),
                  controller: controller.price,
                  textInputType: TextInputType.name,
                  hintStyle: Get.textTheme.titleMedium!.copyWith(
                      color: AppColors.colorSecondary600,
                      fontSize: AppSizes.s12),
                );
              },
            ),
            AppSizes.s20.height,
            InputWidget(
              label: AppConstants.LABEL_WEIGHT,
              hintText: AppConstants.LABEL_WEIGHT,
              controller: controller.weight,
              textInputType: TextInputType.name,
              hintStyle: Get.textTheme.titleMedium!.copyWith(
                  color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
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
                Flexible(
                  child: Button.filled(
                    onPressed: () {
                      showDepositTrashSucces(
                          context: context,
                          icon: Assets.icons.succes.path,
                          label: AppConstants.LABEL_DEPOSIT_TRASH_SUCCES,
                          firstButton: AppConstants.LABEL_SEE_HISTORY,
                          fistOnPressed: () {
                            Get.back();
                            Get.back();
                          },
                          secondButton: AppConstants.LABEL_BERANDA,
                          seccondOnPressed: () {
                            Get.offAllNamed(AppRoutes.home);
                          },
                          showButton: true);
                    },
                    label: AppConstants.ACTION_DEPOSIT,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
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
