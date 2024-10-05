import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/transaction_card_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/controllers/withdraw_funds_controller.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';

class WithdrawFundsScreen extends StatelessWidget {
  const WithdrawFundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawFundsController controller =
        Get.put(WithdrawFundsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.LABEL_WITHDRAW_FUNDS,
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
        children: [
          SearchComponent(controller: TextEditingController(), onTap: () {}),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Divider(
                color: AppColors.colorNeutrals100,
                thickness: 1,
              ),
              Obx(
                () {
                  return Row(
                    children: [
                      Flexible(
                        child: MenuButtonWidget(
                          label: AppConstants.ACTION_PENDING,
                          onTap: () {
                            controller.setActiveButton(0);
                          },
                          isActive: controller.activeButtonIndex.value == 0,
                        ),
                      ),
                      AppSizes.s60.width,
                      Flexible(
                        child: MenuButtonWidget(
                          label: AppConstants.ACTION_SUKSES,
                          onTap: () {
                            controller.setActiveButton(1);
                          },
                          isActive: controller.activeButtonIndex.value == 1,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: AppSizes.s44);
                },
              ),
            ],
          ),
          AppSizes.s20.height,
          Obx(() {
            return controller.activeButtonIndex.value == 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, index) {
                        return TransactionCardComponent(
                          kode: 'Koprasi Mawar',
                          label: 'Mutiara Ayu',
                          date: '26 Juli 2024',
                          amount: 'Rp. 50.000',
                          status: 'Pending',
                          onTap: () {
                            showDepositTrashSucces(
                                context: context,
                                icon: Assets.icons.question.path,
                                label:
                                    AppConstants.LABEL_WITHDRAW_FUNDS_QUESTION,
                                firstButton: AppConstants.ACTION_NO,
                                fistOnPressed: () {
                                  Get.back();
                                },
                                secondButton: AppConstants.ACTION_YES,
                                seccondOnPressed: () {
                                  // controller.setActive(false);
                                  Get.back();
                                },
                                showButton: true);
                          },
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, index) {
                        return TransactionCardComponent(
                          kode: 'KP - 001',
                          label: 'Mutiara Ayu',
                          date: '26 Juli 2024',
                          amount: 'Rp. 50.000',
                          status: 'Sukses',
                        );
                      },
                    ),
                  );
          }),
        ],
      ).paddingSymmetric(horizontal: AppSizes.s20),
    );
  }
}
