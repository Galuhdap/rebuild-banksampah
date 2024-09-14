import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/card_tile_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                InputWidget(
                  label: AppConstants.LABEL_NAME,
                  hintText: AppConstants.LABEL_NAME,
                  controller: TextEditingController(),
                  textInputType: TextInputType.name,
                  readOnly: true,
                ),
                AppSizes.s16.height,
                InputWidget(
                  label: AppConstants.LABEL_PHONE_NUMBER,
                  hintText: AppConstants.LABEL_PHONE_NUMBER,
                  controller: TextEditingController(),
                  textInputType: TextInputType.name,
                  readOnly: true,
                ),
                AppSizes.s16.height,
                InputWidget(
                  label: AppConstants.LABEL_ADDRESS,
                  hintText: AppConstants.LABEL_ADDRESS,
                  controller: TextEditingController(),
                  textInputType: TextInputType.name,
                  readOnly: true,
                ),
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
                      itemCount: 10,
                      itemBuilder: (BuildContext context, index) {
                        return CardTile(
                          title: 'Minyak 1 Liter',
                          stock: '20',
                          price: 'Rp 15.000',
                          onTap: () {
                            //controller.changeStatus(index);
                          },
                          showCheckout: true,
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
                Text(
                  '0',
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.s17,
                      color: AppColors.colorBasePrimary),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                //Get.toNamed(AppRoutes.checkout);
                showDepositTrashSucces(
                  context: context,
                  icon: Assets.icons.mark.path,
                  label: AppConstants.LABEL_PROCESS_ORDER,
                  firstButton: AppConstants.LABEL_SEE_ORDER,
                  fistOnPressed: (){
                    Get.offAndToNamed(AppRoutes.orderSee);
                  },
                  showButton: false,
                );
              },
              child: Container(
                padding: AppSizes.symmetricPadding(
                    vertical: AppSizes.s27, horizontal: AppSizes.s35),
                color: AppColors.colorBasePrimary,
                child: Text(
                  'Buat Pesanan',
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.s16, color: AppColors.colorBaseWhite),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
