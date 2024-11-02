import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/card_tile_component.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/basket_controller.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/shopping_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingController>(
      init: ShoppingController(),
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
                  AppConstants.LABEL_COOPERATIVE,
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontSize: AppSizes.s18),
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.offAndToNamed(AppRoutes.home);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.put(BasketController());
                      Get.toNamed(AppRoutes.basket);
                    },
                    icon: Badge(
                      label:
                          Text(controller.listProductBasket.length.toString()),
                      textStyle: TextStyle(fontSize: AppSizes.s15),
                      backgroundColor: AppColors.colorBasePrimary,
                      child: SvgPicture.asset(
                        Assets.icons.shop.path,
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ).paddingOnly(right: AppSizes.s10)
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  controller.listProduct.clear();
                  controller.getProductCustomer();
                },
                child: Column(
                  children: [
                    SearchComponent(
                      controller: controller.searchProduct,
                      onTap: () {},
                      onChanged: (value) {
                        controller.searchQuery.value = value;
                        controller.filterSearchTrash();
                      },
                    ),
                    Obx(() {
                      return controller.isLoadingProduct.value
                          ? Center(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Lottie.asset(Assets.lottie.loadingLogin),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: controller.searchQuery.isEmpty
                                    ? controller.listProduct.length
                                    : controller.searchListProduct.length,
                                itemBuilder: (BuildContext context, index) {
                                  var data = controller.searchQuery.isEmpty
                                      ? controller.listProduct[index]
                                      : controller.searchListProduct[index];
                                  //var data = controller.listProduct[index];
                                  final isInBasket = controller
                                      .listProductBasket
                                      .any((basketProduct) =>
                                          basketProduct.id == data.id);
                                  return Obx(
                                    () {
                                      return CardTile(
                                        title: data.name,
                                        stock: data.stock,
                                        price: data.price.currencyFormatRp,
                                        imageUrl: data.image,
                                        productBasket: isInBasket,
                                        quantity:
                                            controller.quantities[index] ?? 0,
                                        onTap: isInBasket
                                            ? null
                                            : () {
                                                controller.changeStatus(index);
                                                controller.insert(
                                                    idfav: data.id,
                                                    stock:
                                                        controller.quantities[
                                                                index] ??
                                                            0);
                                              },
                                        isActive: controller.activeIndices
                                            .contains(index),
                                        // onTapMin: () =>
                                        //     controller.changeQuantityMin(index),
                                        // onTapPlus: () =>
                                        //     controller.changeQuantityAdd(index),Í
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                    })
                  ],
                ).paddingSymmetric(horizontal: AppSizes.s20),
              )),
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
