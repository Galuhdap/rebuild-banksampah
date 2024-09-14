import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/card_tile_component.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/shopping_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingController>(
      init: ShoppingController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppConstants.LABEL_COOPERATIVE,
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
              SearchComponent(
                  controller: TextEditingController(), onTap: () {}),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, index) {
                    return Obx(
                      () {
                        return CardTile(
                          title: 'Minyak 1 Liter',
                          stock: '20',
                          price: 'Rp 15.000',
                          quantity: controller.quantity.value,
                          onTap: () {
                            controller.changeStatus(index);
                            print(controller.total.value);
                            showBottomSheet(
                              backgroundColor: AppColors.colorBaseWhite,
                              context: context,
                              builder: (context) => Container(
                                width: double.infinity,
                                // height: 100,
                                //padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        AppSizes.s25.width,
                                        Text(
                                          'Total :',
                                          style: Get.textTheme.titleLarge!
                                              .copyWith(
                                            fontSize: AppSizes.s15,
                                          ),
                                        ),
                                        AppSizes.s20.width,
                                        Obx(() {
                                          return Text(
                                            '${controller.total.value}',
                                            style: Get.textTheme.titleLarge!
                                                .copyWith(
                                                    fontSize: AppSizes.s17,
                                                    color: AppColors
                                                        .colorBasePrimary),
                                          );
                                        })
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.checkout);
                                      },
                                      child: Container(
                                        padding: AppSizes.symmetricPadding(
                                            vertical: AppSizes.s27,
                                            horizontal: AppSizes.s35),
                                        color: AppColors.colorBasePrimary,
                                        child: Text(
                                          'Checkout',
                                          style: Get.textTheme.titleLarge!
                                              .copyWith(
                                                  fontSize: AppSizes.s16,
                                                  color:
                                                      AppColors.colorBaseWhite),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          isActive: controller.activeIndex.value == index,
                          onTapMin: () => controller.changeQuantityMin(),
                          onTapPlus: () => controller.changeQuantityAdd(),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ).paddingSymmetric(horizontal: AppSizes.s20),
        );
      },
    );
  }
}

// void bottoms(BuildContext context) {
//   showBottomSheet(
//     backgroundColor: AppColors.colorBaseWhite,
//     context: context,
//     builder: (context) => Container(
//       width: double.infinity,
//       // height: 100,
//       //padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               AppSizes.s25.width,
//               Text(
//                 'Total :',
//                 style: Get.textTheme.titleLarge!.copyWith(
//                   fontSize: AppSizes.s15,
//                 ),
//               ),
//               AppSizes.s20.width,
//               Text(
//                 '${controller.total.value}' ?? '0',
//                 style: Get.textTheme.titleLarge!.copyWith(
//                     fontSize: AppSizes.s17, color: AppColors.colorBasePrimary),
//               ),
//             ],
//           ),
//           InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Container(
//               padding: AppSizes.symmetricPadding(
//                   vertical: AppSizes.s27, horizontal: AppSizes.s35),
//               color: AppColors.colorBasePrimary,
//               child: Text(
//                 'Checkout',
//                 style: Get.textTheme.titleLarge!.copyWith(
//                     fontSize: AppSizes.s16, color: AppColors.colorBaseWhite),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
