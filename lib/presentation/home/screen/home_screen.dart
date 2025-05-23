import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/menu_category_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/home/controllers/home_controller.dart';
import 'package:rebuild_bank_sampah/presentation/profile/controllers/profile_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(ProfileController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: RefreshIndicator(
          onRefresh: () async {
            controller.getBalanceCustomer();
            controller.getSummaryWeigher();
            controller.getSummaryAdminKoprasi();
          },
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppConstants.LABEL_WELCOME,
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontSize: AppSizes.s18)),
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
                        Obx(() {
                          if (controllers.profile.value != null) {
                            return Text(
                              'Hi, ${controllers.profile.value!.name}',
                              style: Get.textTheme.titleLarge!.copyWith(
                                  fontSize: AppSizes.s16,
                                  color: AppColors.colorBaseWhite),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                        AppSizes.s10.height,
                        Obx(() {
                          return Text(
                            controller.role.value,
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: AppColors.colorBaseWhite),
                          );
                        }),
                        AppSizes.s20.height,
                        Obx(
                          () {
                            return controller.role.value == 'WEIGHER'
                                ? Text(
                                    'Berat',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                        color: AppColors.colorBaseWhite),
                                  )
                                : controller.role.value == 'SUPER_ADMIN'
                                    ? SizedBox()
                                    : Text(
                                        'Saldo',
                                        style: Get.textTheme.bodyMedium!
                                            .copyWith(
                                                color:
                                                    AppColors.colorBaseWhite),
                                      );
                          },
                        ),
                        AppSizes.s4.height,
                        Obx(() {
                          return controller.role.value == 'WEIGHER'
                              ? controller.isLoadingCustomer.value
                                  ? CircularProgressIndicator()
                                  : Text(
                                      '${controller.summaryWeigher.value?.weight ?? 'tunggu...'} KG',
                                      style: Get.textTheme.titleLarge!.copyWith(
                                          fontSize: AppSizes.s24,
                                          color: AppColors.colorBaseWhite),
                                    )
                              : controller.role.value == 'SUPER_ADMIN'
                                  ? SizedBox(
                                      height: 20,
                                    )
                                  : controller.role.value == 'ADMIN'
                                      ? controller.isLoadingAdminKoprasi.value
                                          ? Center(
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Lottie.asset(
                                                    Assets.lottie.loadingLogin),
                                              ),
                                            )
                                          : Text(
                                              (controller.summaryAdminKoprasi
                                                          .value?.balance ??
                                                      0)
                                                  .currencyFormatRp,
                                              style: Get.textTheme.titleLarge!
                                                  .copyWith(
                                                      fontSize: AppSizes.s24,
                                                      color: AppColors
                                                          .colorBaseWhite),
                                            )
                                      : controller.isLoadingCustomer.value
                                          ? Center(
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Lottie.asset(
                                                    Assets.lottie.loadingLogin),
                                              ),
                                            )
                                          : Text(
                                              (controller.balanceCustomer.value
                                                          ?.balance ??
                                                      0)
                                                  .currencyFormatRp,
                                              style: Get.textTheme.titleLarge!
                                                  .copyWith(
                                                      fontSize: AppSizes.s24,
                                                      color: AppColors
                                                          .colorBaseWhite),
                                            );
                        })
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
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontSize: AppSizes.s18)),
              AppSizes.s20.height,

              //AdminKoprasi

              //CUSTOMER
              Obx(
                () {
                  return controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Lottie.asset(Assets.lottie.loadingLogin),
                          ),
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
                                // AppSizes.s17.height,
                                // MenuKategoriComponent(
                                //   onTap: () {
                                //     Get.toNamed(AppRoutes.withdrawFunds);
                                //   },
                                //   image: Assets.images.withdrawal.path,
                                //   label: AppConstants.LABEL_WITHDRAW_FUNDS,
                                // ),
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
                                              Get.toNamed(AppRoutes
                                                  .customerTrashDeposit);
                                            },
                                            image: Assets.images.recycle.path,
                                            label: AppConstants
                                                .LABEL_DEPOSIT_TRASH,
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
                                            // onTap: () {},
                                            image: Assets.images.shopping.path,
                                            label:
                                                AppConstants.ACTION_COOPERATIVE,
                                            disabel: false,
                                          ),
                                        ),
                                        AppSizes.s20.width,
                                        Flexible(
                                          child: MenuKategoriComponent(
                                            disabel: false,
                                            onTap: () {
                                              Get.toNamed(AppRoutes.orderSee);
                                            },
                                            image: Assets.images.received.path,
                                            label: AppConstants.ACTION_ORDER,
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppSizes.s17.height,
                                    Row(
                                      children: [
                                        Flexible(
                                          child: MenuKategoriComponent(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoutes.trashPriceCustomer);
                                            },
                                            image: Assets.images.trash.path,
                                            label:
                                                AppConstants.LABEL_PRICE_TRASH,
                                          ),
                                        ),
                                        Flexible(child: Container()),
                                      ],
                                    )
                                  ],
                                )
                              : controller.role.value == 'SUPER_ADMIN'
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: MenuKategoriComponent(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoutes.profile);
                                                },
                                                image: Assets.images.user.path,
                                                label:
                                                    AppConstants.LABEL_PROFILE,
                                              ),
                                            ),
                                            AppSizes.s20.width,
                                            Flexible(
                                              child: MenuKategoriComponent(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoutes.withdrawFunds);
                                                },
                                                image: Assets
                                                    .images.withdrawal.path,
                                                label: AppConstants
                                                    .LABEL_WITHDRAW_FUNDS,
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
                                                  Get.toNamed(
                                                      AppRoutes.priceTrash);
                                                },
                                                image: Assets.images.trash.path,
                                                label: AppConstants
                                                    .LABEL_PRICE_TRASH,
                                              ),
                                            ),
                                            AppSizes.s20.width,
                                            Flexible(
                                              child: MenuKategoriComponent(
                                                onTap: () {
                                                  // Get.toNamed(
                                                  //   AppRoutes.priceTrash);
                                                  Get.toNamed(
                                                      AppRoutes.register);
                                                },
                                                image: Assets
                                                    .images.manageUser.path,
                                                label: AppConstants
                                                    .LABEL_REGISTER_USER,
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
                                                  Get.toNamed(AppRoutes
                                                      .depositTrashSuperAdmin);
                                                },
                                                image:
                                                    Assets.images.recycle.path,
                                                label: AppConstants
                                                    .LABEL_DEPOSIT_TRASH,
                                              ),
                                            ),
                                            AppSizes.s20.width,
                                            Flexible(
                                              child: MenuKategoriComponent(
                                                onTap: () {
                                                  Get.toNamed(AppRoutes.report);
                                                },
                                                scale: 5.5,
                                                image: Assets.images.graph.path,
                                                label: AppConstants
                                                    .LABEL_GRAFIK_TRASH,
                                              ),
                                            ),
                                          ],
                                        ),
                                        AppSizes.s20.height,
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
                                                  Get.toNamed(
                                                      AppRoutes.profile);
                                                },
                                                image: Assets.images.user.path,
                                                label:
                                                    AppConstants.LABEL_PROFILE,
                                              ),
                                            ),
                                            AppSizes.s20.width,
                                            Flexible(
                                              child: MenuKategoriComponent(
                                                onTap: () {
                                                  Get.toNamed(AppRoutes
                                                      .withdrawFundAdminKoprasi);
                                                },
                                                image: Assets
                                                    .images.withdrawal.path,
                                                label:
                                                    AppConstants.LABEL_WITHDRAW,
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
                                                  Get.toNamed(
                                                      AppRoutes.shopAdmin);
                                                },
                                                image:
                                                    Assets.images.shopping.path,
                                                label: AppConstants
                                                    .ACTION_COOPERATIVE,
                                              ),
                                            ),
                                            AppSizes.s20.width,
                                            Flexible(
                                              child: MenuKategoriComponent(
                                                onTap: () {
                                                  Get.toNamed(AppRoutes
                                                      .orderAdminKoprasi);
                                                },
                                                image:
                                                    Assets.images.received.path,
                                                label:
                                                    AppConstants.ACTION_ORDER,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                },
              ),
            ],
          ).paddingSymmetric(horizontal: AppSizes.s24, vertical: AppSizes.s27),
        ));
      },
    );
  }
}
