import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/basket_controller.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/shopping_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final CheckoutController controllerCheckout = Get.put(CheckoutController());
    final ShoppingController controllers = Get.find();
    return GetBuilder<BasketController>(
      init: BasketController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.colorBaseWhite,
            bottomNavigationBar: Container(
                height: 71,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -2),
                      blurRadius: 30.0,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0,
                      color: AppColors.colorBaseBlack.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSizes.s0.width,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.toggleSelectAll();
                          },
                          child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: controller.isAllSelected()
                                  ? Center(
                                      child: SvgPicture.asset(
                                          Assets.icons.checklist.path),
                                    )
                                  : SizedBox()),
                        ),
                        AppSizes.s5.width,
                        Text(
                          'Semua',
                          style: Get.textTheme.titleMedium!
                              .copyWith(fontSize: AppSizes.s12),
                        ),
                      ],
                    ),
                    AppSizes.s20.width,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total : ',
                          style: Get.textTheme.titleMedium!.copyWith(
                              fontSize: AppSizes.s14,
                              fontWeight: FontWeight.bold),
                        ),
                        Obx(() {
                          return Text(
                            controller.total.value.currencyFormatRp,
                            style: Get.textTheme.titleMedium!.copyWith(
                                fontSize: AppSizes.s16,
                                color: AppColors.colorBasePrimary,
                                fontWeight: FontWeight.bold),
                          );
                        })
                      ],
                    ),
                    AppSizes.s15.width,
                    Flexible(
                      child: Obx(
                        () {
                          return InkWell(
                            onTap: controller.isBalanceSufficient.value
                                ? () {
                                    Get.toNamed(AppRoutes.checkout, arguments: {
                                      'quantities': controller.quantities,
                                      'productIds': controller.productIds,
                                      'total': controller.total.value,
                                    });
                                  }
                                : null,
                            child: Container(
                              width: 152,
                              height: 71,
                              decoration: BoxDecoration(
                                color: controller.isBalanceSufficient.value
                                    ? AppColors.colorBasePrimary
                                    : AppColors.colorNeutrals500,
                              ),
                              child: controller.isBalanceSufficient.value
                                  ? Center(
                                      child: Text(
                                        'Checkout',
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(
                                                fontSize: AppSizes.s14,
                                                color: AppColors.colorBaseWhite,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        '*Saldo tidak cukup',
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(
                                                fontSize: AppSizes.s12,
                                                color: AppColors.colorBaseWhite,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
            appBar: AppBar(
              title: Text(
                '${AppConstants.LABEL_BASKET} (${controllers.listProductBasket.length})',
                style:
                    Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
              ),
              leading: IconButton(
                onPressed: () async {
                  controllers.activeIndices.clear();
                  Get.offAndToNamed(AppRoutes.shop);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.colorBaseBlack,
                ),
              ),
            ),
            body: Column(
              children: [
                AppSizes.s12.height,
                Expanded(
                  child: Container(
                    padding: AppSizes.allPadding(AppSizes.s20),
                    color: Color(0xffffffff),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pesanan Anda',
                          style: Get.textTheme.titleMedium!.copyWith(
                              fontSize: AppSizes.s16,
                              fontWeight: FontWeight.bold),
                        ),
                        AppSizes.s20.height,
                        controllers.listProductBasket.isEmpty
                            ? Container(
                                padding: AppSizes.symmetricPadding(
                                    vertical: AppSizes.s140),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Assets.images.boxKosong.image(scale: 4),
                                      AppSizes.s16.height,
                                      Text(
                                        'Pesanan Kosong',
                                        style: Get.textTheme.titleLarge!
                                            .copyWith(fontSize: AppSizes.s18),
                                      ),
                                      AppSizes.s12.height,
                                      Text(
                                        'Pesananmu masih kosong nih\nmulai belanja yuk!',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: Get.textTheme.titleLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s14,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      AppSizes.s16.height,
                                      Button.filled(
                                              onPressed: () {
                                                controllers.activeIndices
                                                    .clear();
                                                Get.offAndToNamed(
                                                    AppRoutes.shop);
                                              },
                                              label: 'Mulai Belanja')
                                          .paddingSymmetric(
                                              horizontal: AppSizes.s80)
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      controllers.listProductBasket.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data =
                                        controllers.listProductBasket[index];
                                    return Obx(
                                      () {
                                        return Dismissible(
                                          key: Key(data.id
                                              .toString()), // Setiap item harus memiliki key unik
                                          direction: DismissDirection
                                              .endToStart, // Geser hanya ke kiri
                                          background: Container(
                                            margin: AppSizes.onlyPadding(
                                              bottom: AppSizes.s16,
                                            ),
                                            padding: AppSizes.symmetricPadding(
                                                vertical: AppSizes.s12,
                                                horizontal: AppSizes.s12),
                                            color: AppColors
                                                .colorError300, // Warna background ketika digeser
                                            child: Center(
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          onDismissed: (direction) {
                                            // Aksi yang dilakukan ketika item digeser sepenuhnya
                                            controller.removeItem(index);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      '${data.name} dihapus')),
                                            );
                                          },
                                          child: BasketCardWidget(
                                            stock: data.stock,
                                            label: data.name,
                                            price: data.price.currencyFormatRp,
                                            quantity:
                                                controller.quantities[index] ??
                                                    1,
                                            imageUrl: data.image,
                                            checkList: () {
                                              controller.changeStatus(index);
                                            },
                                            isActiveCheck: controller
                                                .activeIndices
                                                .contains(index),
                                            controller: controller,
                                            onTapMin: () => controller
                                                .changeQuantityMin(index),
                                            onTapPlus: () => controller
                                                .changeQuantityAdd(index),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

class BasketCardWidget extends StatelessWidget {
  final String label;
  final String price;
  final int? quantity;
  final int? stock;
  final String? imageUrl;
  final VoidCallback checkList;
  final bool isActiveCheck;
  final VoidCallback? onTapMin;
  final VoidCallback? onTapPlus;
  const BasketCardWidget(
      {super.key,
      required this.label,
      this.imageUrl,
      required this.price,
      required this.quantity,
      required this.checkList,
      required this.isActiveCheck,
      required this.onTapMin,
      required this.onTapPlus,
      required this.stock,
      required this.controller});

  final BasketController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSizes.onlyPadding(
        bottom: AppSizes.s16,
      ),
      padding: AppSizes.symmetricPadding(
          vertical: AppSizes.s12, horizontal: AppSizes.s12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSizes.s8,
          ),
          border: Border.all(color: AppColors.colorBasePrimary)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: checkList,
                child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: isActiveCheck
                        ? Center(
                            child:
                                SvgPicture.asset(Assets.icons.checklist.path),
                          )
                        : SizedBox()),
              ),
              AppSizes.s20.width,
              Container(
                width: 90,
                height: 90,
                // padding: AppSizes.allPadding(
                //     showCheckout ? AppSizes.s40 : AppSizes.s60),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
          AppSizes.s30.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                child: Text(
                  label,
                  style: Get.textTheme.titleMedium!
                      .copyWith(fontSize: AppSizes.s16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              AppSizes.s5.height,
              Text(
                'stock : ${stock}',
                style:
                    Get.textTheme.titleMedium!.copyWith(fontSize: AppSizes.s14),
              ),
              AppSizes.s10.height,
              Text(
                price,
                style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSizes.s14, color: AppColors.colorBasePrimary),
              ),
              AppSizes.s20.height,
              Container(
                width: AppSizes.s100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: InkWell(
                        onTap: onTapMin,
                        child: const ColoredBox(
                          color: AppColors.colorBasePrimary,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.remove,
                              color: AppColors.colorBaseWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(quantity.toString()),
                    ),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: InkWell(
                        onTap: onTapPlus,
                        child: const ColoredBox(
                          color: AppColors.colorBasePrimary,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.add,
                              color: AppColors.colorBaseWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
