import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/shopping_controller.dart';

class CardOrderTileWidget extends StatelessWidget {
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
  final ShoppingController? controller;

  const CardOrderTileWidget({
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
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
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
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              // Center(
              //   child: Container(
              //     padding: AppSizes.allPadding(
              //         showCheckout ? AppSizes.s40 : AppSizes.s60),
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage(Assets.images.minyak.path),
              //       ),
              //     ),
              //   ),
              // ),
              AppSizes.s20.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Get.textTheme.titleMedium!
                        .copyWith(fontSize: AppSizes.s17),
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
                  // showCheckout
                  //     ? SizedBox()
                  //     : Container(
                  //         width: AppSizes.s100,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius:
                  //                   const BorderRadius.all(Radius.circular(5.0)),
                  //               child: InkWell(
                  //                 onTap: isActive! ? onTapMin : () {},
                  //                 child: const ColoredBox(
                  //                   color: AppColors.colorBasePrimary,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.all(4.0),
                  //                     child: Icon(
                  //                       Icons.remove,
                  //                       color: AppColors.colorBaseWhite,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(5),
                  //               child: isActive! ? Text('$quantity') : Text('0'),
                  //             ),
                  //             ClipRRect(
                  //               borderRadius:
                  //                   const BorderRadius.all(Radius.circular(5.0)),
                  //               child: InkWell(
                  //                 onTap: isActive! ? onTapPlus : () {},
                  //                 child: const ColoredBox(
                  //                   color: AppColors.colorBasePrimary,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.all(4.0),
                  //                     child: Icon(
                  //                       Icons.add,
                  //                       color: AppColors.colorBaseWhite,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
