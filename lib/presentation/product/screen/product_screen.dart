import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/product/controllers/product_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        init: ProductController(),
        builder: (controller) {
          return Scaffold(
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
                    controller: TextEditingController(), onTap: () {}),
                Obx(
                  () {
                    return controller.isLoadingProduct.value
                        ? Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView.builder(
                              itemCount: controller.listProduct.length,
                              itemBuilder: (BuildContext context, index) {
                                var data = controller.listProduct[index];
                                return CardProduct(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: AppSizes.s200,
                                          padding: AppSizes.symmetricPadding(
                                              horizontal: AppSizes.s24),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(AppSizes.s16),
                                              topRight:
                                                  Radius.circular(AppSizes.s16),
                                            ),
                                            color: AppColors.colorBaseWhite,
                                          ),
                                          child: Column(
                                            children: [
                                              AppSizes.s16.height,
                                              Center(
                                                child: Container(
                                                  width: AppSizes.s40,
                                                  height: AppSizes.s4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppSizes.s2),
                                                      color: AppColors
                                                          .colorNeutrals200),
                                                ),
                                              ),
                                              AppSizes.s26.height,
                                              InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.create_rounded,
                                                      color: AppColors
                                                          .colorPrimary600,
                                                    ),
                                                    AppSizes.s24.width,
                                                    Text(
                                                      AppConstants
                                                          .LABEL_EDIT_PROFILE,
                                                      style: Get
                                                          .textTheme.titleLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              AppSizes.s37.height,
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: AppColors
                                                        .colorBaseError,
                                                  ),
                                                  AppSizes.s24.width,
                                                  Text(
                                                    AppConstants.LABEL_DELETE,
                                                    style: Get
                                                        .textTheme.titleLarge!
                                                        .copyWith(
                                                            fontSize:
                                                                AppSizes.s18),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
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
                  child: CachedNetworkImage(
                    imageUrl: data.image,
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
                    data.price.toString(),
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
