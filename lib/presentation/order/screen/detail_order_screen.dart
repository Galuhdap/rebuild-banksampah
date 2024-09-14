import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/component/card_tile_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class DetailOrderScreen extends StatelessWidget {
  const DetailOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.ACTION_ORDER,
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
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode Pesanan',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
              Text(
                'P-7I539743',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
            ],
          ),
          AppSizes.s20.height,
          Text(
            '*Tunjukkan kode ini untuk mengambil pesanan ke admin koperasi',
            style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSizes.s10, color: AppColors.colorNeutrals500),
          ),
          AppSizes.s20.height,
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, index) {
                return CardTile(
                  title: 'Minyak 1 Liter',
                  stock: '20',
                  price: 'Rp 15.000',
                  onTap: () {
                    //controller.changeStatus(index);
                  },
                  isActive: false,
                  showCheckout: true,
                  showOrder: false,
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
                  'Total Pesanan :',
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSizes.s15,
                  ),
                ),
                AppSizes.s20.width,
                Text(
                  '0',
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.s17,
                      color: AppColors.colorBasePrimary),
                ),
              ],
            ),
            AppSizes.s20.height,
            Button.outlined(onPressed: () {}, label: 'Batalkan Pesanan', borderRadius: AppSizes.s4,)
          ],
        ),
      ),
    );
  }
}
