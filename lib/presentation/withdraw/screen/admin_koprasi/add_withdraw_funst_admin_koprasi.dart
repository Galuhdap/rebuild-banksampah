import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/helpers/validation_helper.dart';
import 'package:rebuild_bank_sampah/presentation/home/controllers/home_controller.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/profile/controllers/profile_controller.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/controllers/withdraw_funst_admin_koprasi_controller.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/screen/admin_koprasi/loading_admin_koprasi.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class AddWithdrawFunstAdminKoprasi extends StatelessWidget {
  const AddWithdrawFunstAdminKoprasi({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controllerProfile = Get.put(ProfileController());
    HomeController controllerHome = Get.put(HomeController());
    WithdrawFunstAdminKoprasiController controller = Get.put(WithdrawFunstAdminKoprasiController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.ACTION_WITHDRAW_FUNDS,
          style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.home);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.colorBaseBlack,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        //height: 200,
        // height: 100,
        padding: const EdgeInsets.all(16.0),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button.filled(
              onPressed: () async {
                Get.to(LoadingAdminKoprasi(label: 'Penagajuan Penarikan Dana Berhasil',));
                await controller.postWithdrawAdminKoprasi(controllerProfile.profile.value!.name);
              },
              label: 'Ajukan',
            )
          ],
        ),
      ),
      body: Column(
        children: [
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo koprasi :',
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: AppSizes.s16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (controllerHome.summaryAdminKoprasi.value?.balance ?? 0)
                    .currencyFormatRp,
                style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSizes.s14, color: AppColors.colorBasePrimary),
              ),
            ],
          ),
          AppSizes.s20.height,
          InputWidget(
            label: AppConstants.LABEL_NAME_COORPT,
            controller: TextEditingController(text: controllerProfile.profile.value!.name),
            readOnly: true,
          ),
          AppSizes.s20.height,
          InputWidget(
            label: AppConstants.LABEL_NAME_ADMIN_COORPT,
            hintText: AppConstants.INPUT_NAME_ADMIN_COORPT,
            controller: controller.nemeController,
          ),
          AppSizes.s20.height,
          InputWidget(
            label: AppConstants.LABEL_FUNDS_WITHDRAW_COORPT,
            hintText: AppConstants.INPUT_FUNDS_WITHDRAW_COORPT,
            controller: controller.fundsController,
            validator: emptyValidation,
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter.currency(
                locale: 'id',
                symbol: 'Rp ',
                decimalDigits: 0,
              ),
            ],
            textInputType: TextInputType.number,
          ),
        ],
      ).paddingSymmetric(
        horizontal: AppSizes.s20,
      ),
    );
  }
}
