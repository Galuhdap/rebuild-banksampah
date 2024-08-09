import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

void showDepositTrashSucces(BuildContext context) {
  Get.dialog(
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
            SvgPicture.asset(Assets.icons.succes.path),
            AppSizes.s40.height,
            Center(
              child: Text(AppConstants.LABEL_DEPOSIT_TRASH_SUCCES,
                  style: Get.textTheme.labelLarge),
            ),
            AppSizes.s40.height,
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    label: AppConstants.LABEL_SEE_HISTORY,
                  ),
                ),
                AppSizes.s22.width,
                Flexible(
                  child: Button.filled(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.home);
                    },
                    label: AppConstants.LABEL_BERANDA,
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