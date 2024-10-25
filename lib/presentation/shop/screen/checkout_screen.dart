import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/card_tile_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/profile/controllers/profile_controller.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/checkout_controller.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/shopping_controller.dart';
import 'package:rebuild_bank_sampah/presentation/shop/screen/loading_shop_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShoppingController controllers = Get.put(ShoppingController());
    //final BasketController controllerBasket = Get.find();
    ProfileController controllerProfile = Get.put(ProfileController());
    return GetBuilder<CheckoutController>(
      init: CheckoutController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorNeutrals0,
          appBar: AppBar(
            title: Text(
              AppConstants.LABEL_CHECKOUT,
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
              Container(
                padding: AppSizes.symmetricPadding(
                  vertical: AppSizes.s40,
                  horizontal: AppSizes.s20,
                ),
                color: AppColors.colorBaseWhite,
                child: Column(
                  children: [
                    Obx(() {
                      if (controllerProfile.profile.value != null) {
                        return InputWidget(
                          label: AppConstants.LABEL_NAME,
                          controller: TextEditingController(
                              text: controllerProfile.profile.value!.name),
                          readOnly: true,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                    AppSizes.s16.height,
                    Obx(() {
                      if (controllerProfile.profile.value != null) {
                        return InputWidget(
                          label: AppConstants.LABEL_PHONE_NUMBER,
                          controller: TextEditingController(
                              text: controllerProfile.profile.value!.telp),
                          readOnly: true,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                    AppSizes.s16.height,
                    Obx(() {
                      if (controllerProfile.profile.value != null) {
                        return InputWidget(
                          label: AppConstants.LABEL_ADDRESS,
                          controller: TextEditingController(
                              text: controllerProfile.profile.value!.address),
                          readOnly: true,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                  ],
                ),
              ),
              AppSizes.s12.height,
              Expanded(
                child: Container(
                  padding: AppSizes.onlyPadding(
                    right: AppSizes.s20,
                    left: AppSizes.s20,
                    top: AppSizes.s20,
                  ),
                  color: AppColors.colorBaseWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pesanan Anda',
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSizes.s17,
                        ),
                      ),
                      AppSizes.s16.height,
                      Expanded(
                        child: ListView.builder(
                          itemCount: controllers.listProductBasket.length,
                          itemBuilder: (BuildContext context, index) {
                            var data = controllers.listProductBasket[index];
                            print('Cek ${data.id.toString()}');
                            return Obx(
                              () {
                                return CardTile(
                                  title: data.name,
                                  showOrder: false,
                                  quantity: controller.quantities[index] ?? 1,
                                  price: data.price.currencyFormatRp,
                                  productBasket: false,
                                  imageUrl: data.image,
                                  onTap: () {
                                    //controller.changeStatus(index);
                                  },
                                  showCheckout: true,
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            // height: 100,
            //padding: const EdgeInsets.all(16.0),
            //color: AppColors.colorBaseWhite,
            decoration: BoxDecoration(
              color: AppColors.colorBaseWhite,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 12.0,
                  spreadRadius: 4,
                  color: AppColors.colorSecondary500.withOpacity(0.4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    AppSizes.s25.width,
                    Text(
                      'Total :',
                      style: Get.textTheme.titleLarge!.copyWith(
                        fontSize: AppSizes.s15,
                      ),
                    ),
                    AppSizes.s20.width,
                    Obx(() {
                      return Text(
                        controller.total.value.currencyFormatRp,
                        style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorBasePrimary,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    await controller.postBuyProduct(context);
                    await controller.removeItem();
                    // showDepositTrashSucces(
                    //   context: context,
                    //   icon: Assets.icons.mark.path,
                    //   label: AppConstants.LABEL_PROCESS_ORDER,
                    //   firstButton: AppConstants.LABEL_SEE_ORDER,
                    //   fistOnPressed: () {
                    //     Get.offAndToNamed(AppRoutes.orderSee);
                    //   },
                    //   showButton: false,
                    // );
                  },
                  child: Container(
                    padding: AppSizes.symmetricPadding(
                        vertical: AppSizes.s27, horizontal: AppSizes.s35),
                    color: AppColors.colorBasePrimary,
                    child: Text(
                      'Buat Pesanan',
                      style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSizes.s16,
                          color: AppColors.colorBaseWhite),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
