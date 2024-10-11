import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class UDWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const UDWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.colorBaseError,
          ),
          AppSizes.s24.width,
          Text(
            name,
            style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
          ),
        ],
      ),
    );
  }
}
