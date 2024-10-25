import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/edit_deposit_trash_screen.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';

class DetailDepositTrashScreen extends StatelessWidget {
  final DepositTrash data;
  const DetailDepositTrashScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    //DepositTrashController controller = Get.find();

    String totalWeight = data.deposits
        .map((deposit) => deposit.weight)
        .reduce((a, b) => a + b)
        .toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Sampah',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ditimbang Pada ${data.createdAt.toFormattedDateDayTimeString()}',
            style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSizes.s10, color: AppColors.colorNeutrals500),
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode User',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
              Text(
                data.user.profile.kdUser,
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
            ],
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama user',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.user.profile.name,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
          AppSizes.s10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.status,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
          AppSizes.s20.height,
          Expanded(
            child: ListView.builder(
              itemCount: data.deposits.length,
              itemBuilder: (BuildContext context, index) {
                var datas = data.deposits[index];
                return CardDepositTileWidget(
                  title: toBeginningOfSentenceCase(datas.trashName!),
                  quantity: datas.weight,
                  price: datas.nominal.currencyFormatRp,
                );
              },
            ),
          )
        ],
      ).paddingAll(AppSizes.s20),
      bottomNavigationBar: Container(
        width: double.infinity,
        //height: 200,
        // height: 100,
        padding: const EdgeInsets.all(16.0),
        //color: AppColors.colorBaseWhite,
        decoration: BoxDecoration(
          color: AppColors.colorBaseWhite,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 12.0,
              spreadRadius: 4,
              color: AppColors.colorSecondary500.withOpacity(0.4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Berat :',
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSizes.s15,
                  ),
                ),
                AppSizes.s20.width,
                Text(
                  '${totalWeight} Kg',
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.s17,
                      color: AppColors.colorBasePrimary),
                ),
              ],
            ),
            if (data.status == 'PENDING') ...[
              AppSizes.s20.height,
              Button.filled(
                onPressed: () async {
                  Get.to(EditDepositTrashScreen(data: data,));
             
                },
                label: 'Update Berat Sampah',
                borderRadius: AppSizes.s4,
              ),
              AppSizes.s12.height,
            ],
          ],
        ),
      ),
    );
  }
}

class CardDepositTileWidget extends StatelessWidget {
  final String title;
  final int? stock;
  final String price;
  final num? quantity;

  const CardDepositTileWidget({
    super.key,
    required this.title,
    this.stock,
    required this.price,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: AppSizes.onlyPadding(bottom: AppSizes.s12),
          padding: AppSizes.symmetricPadding(
            vertical: AppSizes.s12,
            horizontal: AppSizes.s19,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.s8),
              border: Border.all(
                  color: AppColors.colorBasePrimary, width: AppSizes.s1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    Get.textTheme.titleMedium!.copyWith(fontSize: AppSizes.s17),
              ),
              AppSizes.s10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${quantity} Kg',
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSizes.s15,
                    ),
                  ),
                  Text(
                    price,
                    style: Get.textTheme.titleLarge!.copyWith(
                        fontSize: AppSizes.s17,
                        color: AppColors.colorBasePrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
