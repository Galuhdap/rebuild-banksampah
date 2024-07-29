import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class RiwayatWidget extends StatelessWidget {
  final String label;
  final String date;
  final String price;
  const RiwayatWidget(
      {super.key,
      required this.label,
      required this.date,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Get.textTheme.titleMedium!
                        .copyWith(fontSize: AppSizes.s17)),
                AppSizes.s12.height,
                Text(date,
                    style: Get.textTheme.bodyMedium!
                        .copyWith(fontSize: AppSizes.s13)),
              ],
            ),
            Text(price,
                style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSizes.s25, color: AppColors.colorBasePrimary)),
          ],
        ).paddingSymmetric(horizontal: AppSizes.s12),
        AppSizes.s12.height,
        Divider(
          height: 2,
          color: AppColors.colorSecondary700,
        ),
      ],
    ).paddingOnly(bottom: AppSizes.s20);
  }
}