import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/basket_controller.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasketController>(
      init: BasketController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorBaseWhite,
          appBar: AppBar(
            title: Text(
              '${AppConstants.LABEL_BASKET} (${controller.activeIndices.length})',
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
              AppSizes.s12.height,
              Expanded(
                child: Container(
                  padding: AppSizes.allPadding(AppSizes.s20),
                  color: Color(0xffffffff),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (BuildContext context, index) {
                        return BasketCardWidget(
                          label: 'Minyak 1 liter',
                          price: '2000',
                          quantity: '0',
                          checkList: () {
                            controller.changeStatuss(index);
                          },
                          isActiveCheck:
                              controller.activeIndices.contains(index),
                          controller: controller,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BasketCardWidget extends StatelessWidget {
  final String label;
  final String price;
  final String quantity;
  final VoidCallback checkList;
  final bool isActiveCheck;
  const BasketCardWidget(
      {super.key,
      required this.label,
      required this.price,
      required this.quantity,
      required this.checkList,
      required this.isActiveCheck,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: SvgPicture.asset(Assets.icons.checklist.path),
                      )
                    : SizedBox()),
          ),
          Container(
            padding: AppSizes.allPadding(AppSizes.s60),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.minyak.path),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    Get.textTheme.titleMedium!.copyWith(fontSize: AppSizes.s14),
              ),
              AppSizes.s20.height,
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
                        onTap: () {},
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
                      child: Text(quantity),
                    ),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: InkWell(
                        onTap: () {},
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
