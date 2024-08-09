import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/deposit_trash_controller.dart';

void showDepositTrashDialog(
    BuildContext context, String label) {

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
            InputWidget(
              label: AppConstants.LABEL_TYPE_TRASH,
              hintText: AppConstants.LABEL_TYPE_TRASH,
              controller: controller.type_trash,
              textInputType: TextInputType.name,
              hintStyle: Get.textTheme.titleMedium!.copyWith(
                  color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
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
            InputWidget(
              label: AppConstants.LABEL_PRICE,
              hintText: AppConstants.LABEL_PRICE,
              controller: controller.price,
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
                      showDepositTrashSucces(context);
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
