import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class MenuButtonWidget extends StatelessWidget {
  final bool? isActive;
  final String label;
  final VoidCallback onTap;

  const MenuButtonWidget({
    super.key,
    this.isActive,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: Get.textTheme.labelMedium!.copyWith(
                fontSize: AppSizes.s16,
                color: isActive!
                    ? label == 'Pending'
                        ? AppColors.colorWarning300
                        : AppColors.colorSuccess300
                    : AppColors.colorNeutrals600),
          ),
          AppSizes.s10.height,
          Divider(
            color: isActive!
                ? label == 'Pending'
                    ? AppColors.colorWarning300
                    : AppColors.colorSuccess300
                : AppColors.colorBaseWhite,
            thickness: isActive! ? 2 : 0,
          )
        ],
      ),
    );
  }
}
