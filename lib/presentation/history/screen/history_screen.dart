import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/presentation/history/widget/riwayat_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.LABEL_HISTORY, style: Get.textTheme.titleLarge),
        Expanded(
          child: ListView.builder(
            padding: AppSizes.onlyPadding(top: AppSizes.s32),
            itemCount: 10,
            itemBuilder: (BuildContext context, index) {
              return RiwayatWidget(
                label: 'Penyetoran Sampah',
                date: '26 Juli 2024, 16:08',
                price: '+ 2 Kg',
              );
            },
          ),
        ),
      ],
    ).paddingOnly(left: AppSizes.s20, right: AppSizes.s20, top: AppSizes.s20));
  }
}


