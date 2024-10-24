import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';

import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';

import 'package:rebuild_bank_sampah/presentation/trash/controllers/trash_controller.dart';

class AddPriceTrashScreen extends StatelessWidget {
  const AddPriceTrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TrashController controller = Get.put(TrashController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Sampah',
          style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.colorBaseBlack,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: AppSizes.symmetricPadding(
            vertical: AppSizes.s16, horizontal: AppSizes.s16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.colorBaseBlack.withOpacity(0.08),
            ),
          ],
        ),
        child: Button.filled(
          onPressed: () async {
            await controller.postDepositTrash(context);
          },
          label: AppConstants.ACTION_DEPOSIT,
        ),
      ),
      body: ListView(
        children: [
          AppSizes.s20.height,
          InputWidget(
            label: AppConstants.LABEL_NAME_TRASH,
            hintText: AppConstants.LABEL_NAME_TRASH,
            controller: controller.nameController,
            textInputType: TextInputType.name,
            hintStyle: Get.textTheme.titleMedium!.copyWith(
                color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
          ),
          AppSizes.s12.height,
          // InputWidget(
          //   label: AppConstants.LABEL_WEIGHT,
          //   hintText: AppConstants.LABEL_WEIGHT,
          //   controller: controller.weightController,
          //   textInputType: TextInputType.number,
          //   hintStyle: Get.textTheme.titleMedium!.copyWith(
          //       color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
          // ),
          AppSizes.s12.height,
          InputWidget(
            label: AppConstants.LABEL_PRICEs_TRASH,
            hintText: AppConstants.LABEL_PRICEs_TRASH,
            controller: controller.priceController,
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter.currency(
                locale: 'id',
                symbol: 'Rp ',
                decimalDigits: 0,
              ),
            ],
            textInputType: TextInputType.number,
            hintStyle: Get.textTheme.titleMedium!.copyWith(
                color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
          ),
          AppSizes.s20.height,
        ],
      ).paddingSymmetric(
        horizontal: AppSizes.s16,
      ),
    );
  }
}
