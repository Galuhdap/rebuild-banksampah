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
import 'package:rebuild_bank_sampah/services/trash/model/request/price_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';

class EditPriceTrashScreen extends StatelessWidget {
  final String id;
  final GroupTrash? data;
  const EditPriceTrashScreen({super.key, this.data, required this.id});

  @override
  Widget build(BuildContext context) {
    TrashController controller = Get.find();
    final TextEditingController nameController =
        TextEditingController(text: data!.nama);
    final TextEditingController weightController =
        TextEditingController(text: data!.berat.toString());
    final TextEditingController priceController =
        TextEditingController(text: data!.harga.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Harga Sampah',
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
          child: Obx(() {
            return controller.isloadingAddTrash.value
                ? Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Button.filled(
                    onPressed: () async {
                      double? numericValue =
                          double.parse(weightController.text);
                      String inputText = priceController.text
                          .replaceAll(RegExp(r'[^0-9]'), '');
                      final data = PriceTrashRequest(
                        name: nameController.text,
                        price: int.parse(inputText),
                        weight: numericValue,
                      );
                      await controller.editDepositTrash(
                          context: context, data: data, id: id);
                    },
                    label: AppConstants.ACTION_DEPOSIT,
                  );
          })),
      body: ListView(
        children: [
          AppSizes.s20.height,
          InputWidget(
            label: AppConstants.LABEL_NAME_TRASH,
            hintText: AppConstants.LABEL_NAME_TRASH,
            controller: nameController,
            textInputType: TextInputType.name,
            hintStyle: Get.textTheme.titleMedium!.copyWith(
                color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
          ),
          AppSizes.s12.height,
          InputWidget(
            label: AppConstants.LABEL_WEIGHT,
            hintText: AppConstants.LABEL_WEIGHT,
            controller: weightController,
            textInputType: TextInputType.name,
            hintStyle: Get.textTheme.titleMedium!.copyWith(
                color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
          ),
          AppSizes.s12.height,
          InputWidget(
            label: AppConstants.LABEL_PRICEs_TRASH,
            hintText: AppConstants.LABEL_PRICEs_TRASH,
            controller: priceController,
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter.currency(
                locale: 'id',
                symbol: 'Rp ',
                decimalDigits: 0,
              ),
            ],
            textInputType: TextInputType.name,
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
