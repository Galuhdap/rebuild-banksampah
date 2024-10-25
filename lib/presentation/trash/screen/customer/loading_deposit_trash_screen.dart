import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/customer_deposit_trash_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class LoadingDepositTrashScreen extends StatelessWidget {
  final String label;
  const LoadingDepositTrashScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    CustomerDepositTrashController controller = Get.put(CustomerDepositTrashController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Obx(
          () {
            return controller.isPostLoadingDeposit.value
                ? Center(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Lottie.asset(Assets.lottie.loadingSampah),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.icons.succes.path),
                        AppSizes.s10.height,
                        Container(
                          padding:
                              AppSizes.symmetricPadding(horizontal: AppSizes.s10),
                          child: Text(
                            label,
                            style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        AppSizes.s20.height,
                        Button.filled(
                            onPressed: () {
                              Get.offAllNamed(AppRoutes.customerTrashDeposit);
                            },
                            label: AppConstants.LABEL_SEE_HISTORY)
                      ],
                    ).paddingSymmetric(horizontal: AppSizes.s40),
                  );
          },
        ),
      ),
    );
  }
}
