import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

void showDepositTrashSucces(
    {required BuildContext context,
    required String icon,
    required String label,
    required String? firstButton,
    required dynamic Function()? fistOnPressed,
    String? secondButton,
    dynamic Function()? seccondOnPressed,
    required bool showButton}) {
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
            SvgPicture.asset(icon),
            AppSizes.s40.height,
            Center(
              child: Text(label, style: Get.textTheme.labelLarge),
            ),
            AppSizes.s40.height,
            showButton == true
                ? Row(
                    children: [
                      Flexible(
                        child: Button.outlined(
                          onPressed: fistOnPressed!,
                          label: firstButton!,
                        ),
                      ),
                      AppSizes.s22.width,
                      Flexible(
                        child: Button.filled(
                          onPressed: seccondOnPressed!,
                          label: secondButton!,
                        ),
                      ),
                    ],
                  )
                : Button.filled(
                    onPressed: fistOnPressed!,
                    label: firstButton!,
                  ),
          ],
        ),
      ),
    ),
  );
}
