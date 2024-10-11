import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/transaction_card_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/customer_deposit_trash_controller.dart';

class DepositTrashCustomerScreen extends StatelessWidget {
  const DepositTrashCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDepositTrashController>(
        init: CustomerDepositTrashController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppConstants.LABEL_DEPOSIT_TRASH,
                style:
                    Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
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
            body: Column(
              children: [
                SearchComponent(
                  controller: controller.searchDepositTrash,
                  onTap: () {},
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                    controller.filterSearchTrash();
                  },
                ),
                Obx(
                  () {
                    return controller.isloadingDepositTrash.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.listDepositTrash.isEmpty
                            ? Container(
                                padding: AppSizes.symmetricPadding(
                                    vertical: AppSizes.s150),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Assets.images.emptyData.image(scale: 4),
                                      Text(
                                        'Data Kosong',
                                        style: Get.textTheme.titleLarge!
                                            .copyWith(fontSize: AppSizes.s18),
                                      ),
                                      Text(
                                        'Tidak ada data yang bisa ditampilkan sekarang.',
                                        style: Get.textTheme.titleLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: controller.searchQuery.isNotEmpty
                                      ? controller.searchDepositTrashs.length
                                      : controller.listDepositTrash.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = controller.searchQuery.isNotEmpty
                                        ? controller.searchDepositTrashs[index]
                                        : controller.listDepositTrash[index];
                                    return TransactionCardComponent(
                                        kode: data.nominal.currencyFormatRp,
                                        label: data.sampah.nama,
                                        date: data.createdAt
                                            .toDateddmmmyyyyFormattedString(),
                                        amount: '${data.weight} Kg',
                                        isStatus: false,
                                        onTap: null);
                                  },
                                ),
                              );
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: AppSizes.s20),
          );
        });
  }
}
