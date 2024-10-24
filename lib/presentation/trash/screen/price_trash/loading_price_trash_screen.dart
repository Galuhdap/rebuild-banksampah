import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/trash_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class LoadingPriceTrashScreen extends StatelessWidget {
  const LoadingPriceTrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TrashController controller = Get.put(TrashController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Obx(
          () {
            return controller.isloadingAddTrash.value
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
                            'Berhasil Disimpan',
                            style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        AppSizes.s20.height,
                        Button.filled(
                            onPressed: () {
                              Get.offAllNamed(AppRoutes.priceTrash);
                            },
                            label: AppConstants.LABEL_BACK)
                      ],
                    ).paddingSymmetric(horizontal: AppSizes.s40),
                  );
          },
        ),
      ),
    );
  }
}
