import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/update_delete_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/product/controllers/product_controller.dart';
import 'package:rebuild_bank_sampah/presentation/product/screen/edit_product_screen.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        init: ProductController(),
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
                  controller.nameProductController.clear();
                  controller.priceController.clear();
                  controller.stockController.clear();
                  controller.selectedImage.value = null;
                  Get.toNamed(AppRoutes.addProduct);
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
                  AppConstants.LABEL_COOPERATIVE,
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontSize: AppSizes.s18),
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
                    controller: controller.searchProduct,
                    onTap: () {},
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                      controller.filterSearchTrash();
                    },
                  ),
                  Obx(
                    () {
                      return controller.isLoadingProduct.value
                          ? Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: ListView.builder(
                                itemCount: controller.searchQuery.isEmpty
                                    ? controller.listProduct.length
                                    : controller.searchListProduct.length,
                                itemBuilder: (BuildContext context, index) {
                                  var data =
                                      controller.searchQuery.isEmpty
                                          ? controller.listProduct[index]
                                          : controller.searchListProduct[index];
                                  return CardProduct(
                                    onTap: () {
                                      showModalBottom(
                                        context,
                                        Column(
                                          children: [
                                            AppSizes.s8.height,
                                            Center(
                                              child: Container(
                                                width: AppSizes.s56,
                                                height: AppSizes.s4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSizes.s8),
                                                    color: AppColors
                                                        .colorNeutrals800),
                                              ),
                                            ),
                                            AppSizes.s30.height,
                                            UDWidget(
                                              onTap: () {
                                                Get.to(EditProductScreen(
                                                    datas: data));
                                              },
                                              name: AppConstants
                                                  .LABEL_EDIT_PROFILE,
                                              icon: Icons.create_rounded,
                                            ),
                                            AppSizes.s30.height,
                                            UDWidget(
                                              onTap: () async {
                                                showDepositTrashSucces(
                                                    context: context,
                                                    icon: Assets
                                                        .icons.phQuestion.path,
                                                    label: AppConstants
                                                        .LABEL_DELETE_QUESTION,
                                                    firstButton:
                                                        AppConstants.LABEL_NO,
                                                    fistOnPressed: () async {
                                                      Get.back();
                                                      Get.back();
                                                      //Get.toNamed(AppRoutes.priceTrash);
                                                    },
                                                    secondButton:
                                                        AppConstants.LABEL_YES,
                                                    seccondOnPressed: () async {
                                                      // listTrash.clear();
                                                      // await getTrash();

                                                      // await controller
                                                      //     .deteleUserRegister(id);
                                                    },
                                                    showButton: true);
                                              },
                                              name: AppConstants.LABEL_DELETE,
                                              icon: Icons.delete,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    data: data,
                                  );
                                },
                              ),
                            );
                    },
                  ),
                ],
              ).paddingSymmetric(
                horizontal: AppSizes.s20,
                vertical: AppSizes.s12,
              ),
            ),
          );
        });
  }
}

class CardProduct extends StatelessWidget {
  final Product data;
  final VoidCallback onTap;
  const CardProduct({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSizes.onlyPadding(bottom: AppSizes.s12),
      padding: AppSizes.symmetricPadding(
        vertical: AppSizes.s12,
        horizontal: AppSizes.s7,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          border: Border.all(
              color: AppColors.colorBasePrimary, width: AppSizes.s1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: data.image,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              AppSizes.s20.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: Get.textTheme.titleMedium!
                        .copyWith(fontSize: AppSizes.s17),
                  ),
                  AppSizes.s8.height,
                  Text(
                    'Stock : ${data.stock}',
                    style: Get.textTheme.titleLarge!
                        .copyWith(fontSize: AppSizes.s13),
                  ),
                  AppSizes.s20.height,
                  Text(
                    data.price.currencyFormatRp,
                    style: Get.textTheme.titleLarge!.copyWith(
                        fontSize: AppSizes.s17,
                        color: AppColors.colorBasePrimary),
                  ),
                ],
              ).paddingOnly(top: AppSizes.s10),
            ],
          ).paddingOnly(left: AppSizes.s10),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    );
  }
}
