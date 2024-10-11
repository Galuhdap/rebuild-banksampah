import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class MenuKategoriComponent extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String label;
  final bool disabel;
  const MenuKategoriComponent(
      {super.key,
      required this.onTap,
      required this.image,
      required this.label,
      this.disabel = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: AppSizes.s195,
            padding: AppSizes.symmetricPadding(vertical: AppSizes.s15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.s12),
              color: AppColors.colorBaseWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  scale: 3,
                ),
                AppSizes.s21.height,
                Text(
                  label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.titleMedium!.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          disabel
              ? Container(
                  width: double.infinity,
                  height: AppSizes.setResponsiveHeight(context) * 0.08,
                  color: AppColors.colorNeutrals500,
                  child: Center(
                    child: Text(
                      'Masih Belum Bisa Digunakan',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleMedium!.copyWith(
                          fontSize: 15, color: AppColors.colorBaseWhite),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
