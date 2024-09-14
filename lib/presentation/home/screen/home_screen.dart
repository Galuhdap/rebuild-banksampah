import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/menu_category_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/home/controllers/home_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

import '../../trash/controllers/deposit_trash_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DepositTrashController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppConstants.LABEL_WELCOME,
                style:
                    Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18)),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: double.infinity,
                  padding: AppSizes.onlyPadding(
                      top: AppSizes.s25,
                      bottom: AppSizes.s25,
                      left: AppSizes.s20),
                  decoration: BoxDecoration(
                    color: AppColors.colorBasePrimary,
                    borderRadius: BorderRadius.circular(AppSizes.s10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Muti',
                        style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSizes.s16,
                            color: AppColors.colorBaseWhite),
                      ),
                      AppSizes.s4.height,
                      Text(
                        'Kode Pengepul : KP - 0012',
                        style: Get.textTheme.bodyMedium!
                            .copyWith(color: AppColors.colorBaseWhite),
                      ),
                      AppSizes.s40.height,
                      Text(
                        'Saldo',
                        style: Get.textTheme.bodyMedium!
                            .copyWith(color: AppColors.colorBaseWhite),
                      ),
                      AppSizes.s4.height,
                      Text(
                        'Rp. 50.000',
                        style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSizes.s24,
                            color: AppColors.colorBaseWhite),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: AppSizes.s120,
                  height: AppSizes.s110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(AppSizes.s10)),
                    image: DecorationImage(
                        image: AssetImage(Assets.images.oval.path),
                        scale: 4,
                        fit: BoxFit.cover),
                  ),
                )
              ],
            ).paddingSymmetric(vertical: AppSizes.s16),
            Text(AppConstants.LABEL_MENU_CATEGORY,
                style:
                    Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18)),
            AppSizes.s20.height,

            //AdminKoprasi

            //WARGA

            //CUSTOMER
            Obx(
              () {
                return controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.role.value == 'WEIGHER'
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: MenuKategoriComponent(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.profile);
                                      },
                                      image: Assets.images.user.path,
                                      label: AppConstants.LABEL_PROFILE,
                                    ),
                                  ),
                                  AppSizes.s20.width,
                                  Flexible(
                                    child: MenuKategoriComponent(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.setorSampah);
                                      },
                                      image: Assets.images.recycle.path,
                                      label: AppConstants.LABEL_DEPOSIT_TRASH,
                                    ),
                                  ),
                                ],
                              ),
                              AppSizes.s17.height,
                              MenuKategoriComponent(
                                onTap: () {
                                  Get.toNamed(AppRoutes.withdrawFunds);
                                },
                                image: Assets.images.withdrawal.path,
                                label: AppConstants.LABEL_WITHDRAW_FUNDS,
                              ),
                            ],
                          )
                        : controller.role.value == 'CUSTOMER'
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.profile);
                                          },
                                          image: Assets.images.user.path,
                                          label: AppConstants.LABEL_PROFILE,
                                        ),
                                      ),
                                      AppSizes.s20.width,
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.setorSampah);
                                          },
                                          image: Assets.images.recycle.path,
                                          label:
                                              AppConstants.LABEL_DEPOSIT_TRASH,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSizes.s17.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.shop);
                                          },
                                          image: Assets.images.shopping.path,
                                          label:
                                              AppConstants.ACTION_COOPERATIVE,
                                        ),
                                      ),
                                      AppSizes.s20.width,
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.orderSee);
                                          },
                                          image: Assets.images.received.path,
                                          label: AppConstants.ACTION_ORDER,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.profile);
                                          },
                                          image: Assets.images.user.path,
                                          label: AppConstants.LABEL_PROFILE,
                                        ),
                                      ),
                                      AppSizes.s20.width,
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            //Get.toNamed(AppRoutes.withdrawFunds);
                                          },
                                          image: Assets.images.withdrawal.path,
                                          label: AppConstants.LABEL_WITHDRAW,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSizes.s17.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            //Get.toNamed(AppRoutes.profile);
                                          },
                                          image: Assets.images.shopping.path,
                                          label:
                                              AppConstants.ACTION_COOPERATIVE,
                                        ),
                                      ),
                                      AppSizes.s20.width,
                                      Flexible(
                                        child: MenuKategoriComponent(
                                          onTap: () {
                                            //Get.toNamed(AppRoutes.setorSampah);
                                          },
                                          image: Assets.images.received.path,
                                          label: AppConstants.ACTION_ORDER,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
              },
            ),
          ],
        ).paddingSymmetric(horizontal: AppSizes.s24, vertical: AppSizes.s27));
      },
    );
  }
}
