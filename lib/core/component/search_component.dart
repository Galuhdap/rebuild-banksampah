import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/input_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class SearchComponent extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const SearchComponent({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizes.symmetricPadding(
          horizontal: AppSizes.s10, vertical: AppSizes.s17),
      decoration: BoxDecoration(
        color: AppColors.colorBaseWhite,
        borderRadius: BorderRadius.circular(AppSizes.s10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: AppSizes.s50,
              child: CustomTextField(
                controller: controller,
                keyboardType: TextInputType.name,
                fillColor: AppColors.colorNeutrals0,
                hintText: AppConstants.HINT_SEARCH,
                hintStyle: Get.textTheme.titleMedium!.copyWith(
                    color: AppColors.colorSecondary600, fontSize: AppSizes.s15),
                enabledBorderColor: AppColors.colorNeutrals0,
                enabledBorderWidth: AppSizes.s0,
              ),
            ),
          ),
          AppSizes.s15.width,
          InkWell(
            onTap: onTap,
            child: Container(
              padding: AppSizes.allPadding(AppSizes.s10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.s4),
                color: AppColors.colorBasePrimary,
              ),
              child: Icon(
                Icons.search_rounded,
                color: AppColors.colorBaseWhite,
              ),
            ),
          ),
        ],
      ),
    ).paddingOnly(
      bottom: AppSizes.s38,
      top: AppSizes.s15,
    );
  }
}
