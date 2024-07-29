import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/menu_category_component.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/home/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                Assets.images.oval.image(scale: 4)
              ],
            ).paddingSymmetric(vertical: AppSizes.s36),
            Text('Menu Kategori', style: Get.textTheme.titleLarge),
            AppSizes.s20.height,
            Obx(() {
              return controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.role.value == 'CUSTOMER'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: MenuKategoriComponent(
                                onTap: () {},
                                image: Assets.images.recycle.path,
                                label: 'Setor Sampah',
                              ),
                            ),
                            AppSizes.s20.width,
                            Flexible(
                              child: MenuKategoriComponent(
                                onTap: () {},
                                image: Assets.images.withdrawal.path,
                                label: 'Penarikan Dana',
                              ),
                            ),
                          ],
                        )
                      : Text("No Data");
            })
          ],
        ).paddingSymmetric(horizontal: AppSizes.s24));
      },
    );
  }
}
