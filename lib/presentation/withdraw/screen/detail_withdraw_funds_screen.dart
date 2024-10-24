import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/controllers/withdraw_funds_controller.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/status_withdraw_super_admin.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';

class DetailWithdrawFundsScreen extends StatelessWidget {
  final DataWithdrawAdminKoprasi data;
  const DetailWithdrawFundsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    WithdrawFundsController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.ACTION_DETAIL_WITHDRAW_FUNDS,
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
          Text(
            'Diajukan pada ${data.createdAt.toFormattedDateDayTimeString()}',
            style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSizes.s12, color: AppColors.colorNeutrals500),
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama Koprasi',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
              Text(
                data.nameCoop,
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
                'Nama Admin',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
              Text(
                data.nameAdmin,
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
            ],
          ),
          AppSizes.s60.height,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pengajuan Nominal',
                  style:
                      Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
                ),
                AppSizes.s20.height,
                Text(
                  data.nominal.currencyFormatRp,
                  style: Get.textTheme.bodyLarge!.copyWith(
                      fontSize: AppSizes.s36,
                      color: AppColors.colorBasePrimary),
                ),
              ],
            ),
          ),
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
            if (data.status == 'PENDING') ...[
              AppSizes.s20.height,
              Button.filled(
                onPressed: () async {
                
                  final datas = PostUpdateStatusWithdrawRequest(
                    id: data.id,
                    status: 'DONE',
                  );
                  await controller.postUpdateStatusWithdraw(context, datas);
                },
                label: 'Setujui Penarikan',
                borderRadius: AppSizes.s4,
              )
            ]
          ],
        ),
      ),
    );
  }
}
