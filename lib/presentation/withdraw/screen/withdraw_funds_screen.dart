import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/transaction_card_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/controllers/withdraw_funds_controller.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/screen/detail_withdraw_funds_screen.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';

class WithdrawFundsScreen extends StatelessWidget {
  const WithdrawFundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawFundsController>(
      init: WithdrawFundsController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            // Kondisi yang diinginkan saat tombol back ditekan
            bool shouldNavigate = true; // Sesuaikan kondisinya

            if (shouldNavigate) {
              // Navigasi ke halaman home menggunakan Get.offAndToNamed
              Get.offAllNamed(AppRoutes.home);
              return false; // Mencegah pop langsung, kita kontrol manual navigasinya
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppConstants.LABEL_WITHDRAW_FUNDS,
                style:
                    Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
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
                  controller: controller.searchWithdraw,
                  onTap: () {},
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                    controller.filterSearch();
                  },
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
                                isActive:
                                    controller.activeButtonIndex.value == 0,
                              ),
                            ),
                            AppSizes.s20.width,
                            Flexible(
                              child: MenuButtonWidget(
                                label: AppConstants.ACTION_SUKSES,
                                onTap: () {
                                  controller.setActiveButton(1);
                                },
                                isActive:
                                    controller.activeButtonIndex.value == 1,
                              ),
                            ),
                            AppSizes.s20.width,
                            Flexible(
                              child: MenuButtonWidget(
                                label: AppConstants.ACTION_CENCEL,
                                onTap: () {
                                  controller.setActiveButton(2);
                                },
                                isActive:
                                    controller.activeButtonIndex.value == 2,
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
                      controller.listWithdrawSuperKoprasi.where((order) {
                    if (controller.activeButtonIndex.value == 0) {
                      return order.status == 'PENDING';
                    } else if (controller.activeButtonIndex.value == 1) {
                      return order.status == 'DONE';
                    } else {
                      return order.status == 'CANCEL';
                    }
                  }).toList();
                  return controller.isLoadingGetData.value
                      ? Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Lottie.asset(Assets.lottie.loadingLogin),
                          ),
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
                                        .searchListWithdrawSuperKoprasi.length
                                    : filteredOrders.length,
                                itemBuilder: (BuildContext context, index) {
                                  var order = controller.searchQuery.isNotEmpty
                                      ? controller
                                          .searchListWithdrawSuperKoprasi[index]
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
                                      Get.to(DetailWithdrawFundsScreen(
                                        data: order,
                                      ));
                                      // showDepositTrashSucces(
                                      //     context: context,
                                      //     icon: Assets.icons.question.path,
                                      //     label: AppConstants
                                      //         .LABEL_WITHDRAW_FUNDS_QUESTION,
                                      //     firstButton: AppConstants.ACTION_NO,
                                      //     fistOnPressed: () {
                                      //       Get.back();
                                      //     },
                                      //     secondButton: AppConstants.ACTION_YES,
                                      //     seccondOnPressed: () {
                                      //       // controller.setActive(false);
                                      //       Get.back();
                                      //     },
                                      //     showButton: true);
                                    },
                                  );
                                },
                              ),
                            );
                }),
              ],
            ).paddingSymmetric(horizontal: AppSizes.s20),
          ),
        );
      },
    );
  }
}
