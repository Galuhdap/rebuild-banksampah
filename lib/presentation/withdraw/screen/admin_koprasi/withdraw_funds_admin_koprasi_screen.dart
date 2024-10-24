import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/transaction_card_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/controllers/withdraw_funst_admin_koprasi_controller.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';

class WithdrawFundsAdminKoprasiScreen extends StatelessWidget {
  const WithdrawFundsAdminKoprasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawFunstAdminKoprasiController>(
      init: WithdrawFunstAdminKoprasiController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Get.put(DepositTrashController());
              Get.toNamed(AppRoutes.addWithdrawFundAdminKoprasi);
            },
            backgroundColor: AppColors.colorBasePrimary,
            child: Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: AppSizes.s35,
            ),
          ),
          appBar: AppBar(
            title: Text(
              AppConstants.LABEL_WITHDRAW_FUNDS,
              style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
            ),
            leading: IconButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.home);
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
                controller: TextEditingController(),
                onTap: () {},
                onChanged: (value) {},
              ),
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
                List<DataWithdrawAdminKoprasi> filteredOrders =
                    controller.listWithdrawAdminKoprasi.where((order) {
                  if (controller.activeButtonIndex.value == 0) {
                    return order.status == 'PENDING';
                  } else if (controller.activeButtonIndex.value == 1) {
                    return order.status == 'DONE';
                  } else {
                    return order.status == 'CANCEL';
                  }
                }).toList();
                return controller.isLoadingGetWithdrawAdminKopraso.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : filteredOrders.isEmpty
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
                                    'Tidak ada pesanan untuk status ini.',
                                    style: Get.textTheme.titleLarge!.copyWith(
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
                                  ? controller
                                      .searchListWithdrawAdminKoprasi.length
                                  : filteredOrders.length,
                              itemBuilder: (BuildContext context, index) {
                                var order = controller.searchQuery.isNotEmpty
                                    ? controller
                                        .searchListWithdrawAdminKoprasi[index]
                                    : filteredOrders[index];
                                return TransactionCardComponent(
                                  kode: order.nameCoop,
                                  label: order.nameAdmin,
                                  date: order.createdAt
                                      .toFormattedDateDayTimeString(),
                                  amount: order.nominal.currencyFormatRp,
                                  status: order.status,
                                  isStatus: false,
                                  onTap: () {
                                    showDepositTrashSucces(
                                        context: context,
                                        icon: Assets.icons.question.path,
                                        label: AppConstants
                                            .LABEL_WITHDRAW_FUNDS_QUESTION,
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
                          );
              }),
            ],
          ).paddingSymmetric(horizontal: AppSizes.s20),
        );
      },
    );
  }
}
