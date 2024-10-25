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
import 'package:rebuild_bank_sampah/presentation/home/controllers/home_controller.dart';
import 'package:rebuild_bank_sampah/presentation/profile/controllers/profile_controller.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/controllers/withdraw_funst_admin_koprasi_controller.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/screen/admin_koprasi/detail_withdraw_funs_admin_koprasi_screen.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';

class WithdrawFundsAdminKoprasiScreen extends StatelessWidget {
  const WithdrawFundsAdminKoprasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    Get.put(HomeController());
    return GetBuilder<WithdrawFunstAdminKoprasiController>(
      init: WithdrawFunstAdminKoprasiController(),
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
            body: RefreshIndicator(
              onRefresh: () async {
                controller.listWithdrawAdminKoprasi.clear();
                await controller.getWithdarawAdminKoprasi();
              },
              child: Column(
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
                                      ? controller
                                          .searchListWithdrawAdminKoprasi.length
                                      : filteredOrders.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var order = controller
                                            .searchQuery.isNotEmpty
                                        ? controller
                                                .searchListWithdrawAdminKoprasi[
                                            index]
                                        : filteredOrders[index];
                                    return TransactionCardComponent(
                                      kode: order.nameCoop,
                                      label: order.nameAdmin,
                                      date: order.createdAt
                                          .toFormattedDateDayTimeString(),
                                      amount: order.nominal.currencyFormatRp,
                                      status: order.status,
                                      isStatus: false,
                                      statusColor:
                                          controller.activeButtonIndex.value ==
                                                  0
                                              ? AppColors.colorWarning300
                                              : controller.activeButtonIndex
                                                          .value ==
                                                      1
                                                  ? AppColors.colorPrimary800
                                                  : AppColors.colorBaseError,
                                      onTap: () {
                                        Get.to(
                                            DetailWithdrawFundsAdminKoprasiScreen(
                                          data: order,
                                        ));
                                      },
                                    );
                                  },
                                ),
                              );
                  }),
                ],
              ).paddingSymmetric(horizontal: AppSizes.s20),
            ),
          ),
        );
      },
    );
  }
}
