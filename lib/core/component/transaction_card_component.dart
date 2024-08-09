import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class TransactionCardComponent extends StatelessWidget {
  final String kode;
  final String label;
  final String date;
  final String amount;
  final String? status;
  final bool isStatus;
  final VoidCallback? onTap;

  const TransactionCardComponent({
    super.key,
    required this.kode,
    required this.label,
    required this.date,
    required this.amount,
    this.isStatus = true,
    this.status = 'Sukses',
   this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: AppSizes.symmetricPadding(
                vertical: isStatus ? AppSizes.s18 : AppSizes.s0),
            child: Container(
              padding: AppSizes.allPadding(AppSizes.s12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.s10),
                  border: Border.all(
                    color: AppColors.colorNeutrals100,
                    width: AppSizes.s1,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kode,
                    style: Get.textTheme.labelLarge!
                        .copyWith(fontSize: AppSizes.s15),
                  ),
                  AppSizes.s12.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: Get.textTheme.titleSmall!
                            .copyWith(fontSize: AppSizes.s20),
                      ),
                      Text(
                        amount,
                        style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSizes.s20,
                            color: AppColors.colorPrimary800),
                      ),
                    ],
                  ),
                  AppSizes.s12.height,
                  Text(
                    date,
                    style: Get.textTheme.labelMedium!.copyWith(
                      color: AppColors.colorNeutrals500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isStatus
            ? Positioned(
                right: AppSizes.s12,
                child: Container(
                    padding: AppSizes.symmetricPadding(
                        horizontal: AppSizes.s12, vertical: AppSizes.s6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                        color: status == 'Sukses'
                            ? AppColors.colorSuccess300
                            : AppColors.colorWarning300),
                    child: Text(
                      status!,
                      style: Get.textTheme.titleMedium!
                          .copyWith(color: AppColors.colorBaseWhite, fontSize: AppSizes.s17),
                    )),
              )
            : SizedBox()
      ],
    ).paddingOnly(bottom: isStatus ? AppSizes.s0 : AppSizes.s12);
  }
}
