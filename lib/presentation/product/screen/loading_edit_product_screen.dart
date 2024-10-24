import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/product/controllers/product_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class LoadingEditProductScreen extends StatelessWidget {
  const LoadingEditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    return WillPopScope(
        child: Scaffold(
          body: Obx(
            () {
              return controller.isLoadingEditProduct.value
                  ? Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Lottie.asset(Assets.lottie.loadingTransaction),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.icons.mark.path),
                          AppSizes.s10.height,
                          Container(
                            padding: AppSizes.symmetricPadding(
                                horizontal: AppSizes.s10),
                            child: Text(
                              'Sukses Edit Product',
                              style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSizes.s18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          AppSizes.s20.height,
                          Button.filled(
                              onPressed: () {
                                Get.offAllNamed(AppRoutes.shopAdmin);
                              },
                              label: AppConstants.LABEL_SEE_ORDER)
                        ],
                      ).paddingSymmetric(horizontal: AppSizes.s40),
                    );
            },
          ),
        ),
        onWillPop: () async => false);
  }
}
