import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class CardOrderItem extends StatelessWidget {
  final String date;
  final String invoice;
  final String price;
  final Color statusColor;
  final VoidCallback onTap;

  const CardOrderItem({
    super.key,
    required this.date,
    required this.invoice,
    required this.price,
    required this.statusColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: AppSizes.symmetricPadding(
            horizontal: AppSizes.s20, vertical: AppSizes.s5),
        padding: AppSizes.allPadding(AppSizes.s12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.s10),
          border: Border.all(
            color: AppColors.colorPrimary100,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.s12),
            Text(
              'Dipesan pada ${date}',
              style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSizes.s10, color: AppColors.colorNeutrals500),
            ),
            AppSizes.s16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoice,
                  style:
                      Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
                ),
                Text(
                  price,
                  style: Get.textTheme.bodyLarge!.copyWith(
                      fontSize: AppSizes.s16, color: statusColor),
                ),
              ],
            ),
            AppSizes.s16.height,
            Text(
              '*Tunjukkan kode ini untuk mengambil\npesanan ke admin koperasi',
              style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSizes.s10, color: AppColors.colorNeutrals500),
            ),
          ],
        ),
      ),
    );
  }
}
