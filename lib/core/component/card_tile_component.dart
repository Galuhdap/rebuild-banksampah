import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class CardTile extends StatelessWidget {
  final String title;
  final String stock;
  final String price;
  final int? quantity;
  final bool? isActive;
  final VoidCallback? onTap;
  final VoidCallback? onTapMin;
  final VoidCallback? onTapPlus;
  final bool showCheckout;
  final bool showOrder;

  const CardTile({
    super.key,
    required this.title,
    required this.stock,
    required this.price,
    this.quantity,
    this.isActive,
    this.onTap,
    this.onTapMin,
    this.onTapPlus,
    this.showCheckout = false,
    this.showOrder = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showCheckout ? () {} : onTap,
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
            Center(
              child: Container(
                padding: AppSizes.allPadding(
                    showCheckout ? AppSizes.s40 : AppSizes.s60),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.minyak.path),
                  ),
                ),
              ),
            ),
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
                  width: AppSizes.setResponsiveWidth(context) * 0.52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2000',
                        style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorBasePrimary),
                      ),
                      showCheckout
                          ? Text(
                              '1x',
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: AppSizes.s15,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                AppSizes.s20.height,
                showCheckout
                    ? SizedBox()
                    : Container(
                        width: AppSizes.s100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: InkWell(
                                onTap: isActive! ? onTapMin : () {},
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
                              child: isActive! ? Text('$quantity') : Text('0'),
                            ),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: InkWell(
                                onTap: isActive! ? onTapPlus : () {},
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
      ),
    );
  }
}
