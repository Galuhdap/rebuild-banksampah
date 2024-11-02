import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/shopping_controller.dart';

class CardTile extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final int? stock;
  final String price;
  final int? quantity;
  final bool? isActive;
  final VoidCallback? onTap;
  final VoidCallback? onTapMin;
  final VoidCallback? onTapPlus;
  final bool showCheckout;
  final bool showOrder;
  final bool? productBasket;

  final ShoppingController? controller;

  const CardTile({
    super.key,
    this.imageUrl,
    required this.title,
    this.stock,
    required this.price,
    this.quantity,
    this.isActive,
    this.onTap,
    this.onTapMin,
    this.onTapPlus,
    this.showCheckout = false,
    this.showOrder = true,
    this.productBasket,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        InkWell(
          onTap: stock == 0
              ? null
              : showCheckout
                  ? () {}
                  : onTap,
          child: Container(
            margin: AppSizes.onlyPadding(bottom: AppSizes.s12),
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s12,
              horizontal: AppSizes.s7,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.s8),
                border: Border.all(
                    color: showCheckout
                        ? AppColors.colorNeutrals100
                        : isActive!
                            ? AppColors.colorBasePrimary
                            : AppColors.colorNeutrals100,
                    width: AppSizes.s1)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  // padding: AppSizes.allPadding(
                  //     showCheckout ? AppSizes.s40 : AppSizes.s60),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                AppSizes.s20.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSizes.setResponsiveWidth(context) * 0.55,
                      child: Text(
                        title,
                        style: Get.textTheme.titleMedium!
                            .copyWith(fontSize: AppSizes.s17),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (showOrder) ...[
                      AppSizes.s8.height,
                      Text(
                        'Stock : ${stock}',
                        style: Get.textTheme.titleLarge!
                            .copyWith(fontSize: AppSizes.s13),
                      ),
                    ],
                    AppSizes.s20.height,
                    Container(
                      width: showCheckout
                          ? AppSizes.setResponsiveWidth(context) * 0.55
                          : AppSizes.setResponsiveWidth(context) * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price,
                            style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: AppSizes.s17,
                                color: AppColors.colorBasePrimary),
                          ),
                          showCheckout
                              ? Text(
                                  '${quantity}x',
                                  style: Get.textTheme.titleLarge!.copyWith(
                                    fontSize: AppSizes.s15,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    AppSizes.s20.height,
                  ],
                )
              ],
            ),
          ),
        ),
        stock == 0
            ? Positioned(
                child: Container(
                color: AppColors.colorNeutrals400,
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Product Habis',
                    style: Get.textTheme.titleMedium!
                        .copyWith(fontSize: AppSizes.s17, color: Colors.white),
                  ),
                ),
              ))
            : productBasket!
                ? Positioned(
                    child: Container(
                    color: AppColors.colorNeutrals400,
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Product sudah ada ke keranjang',
                        style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSizes.s17, color: Colors.white),
                      ),
                    ),
                  ))
                : SizedBox(),
      ],
    );
  }
}
