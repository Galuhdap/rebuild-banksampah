import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/register/controllers/register_controller.dart';
import 'package:rebuild_bank_sampah/presentation/register/screen/edit_register_screen.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';

class DetailRegisterScreen extends StatelessWidget {
  final UserData data;
  const DetailRegisterScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());

    // String totalWeight = data.deposits
    //     .map((deposit) => deposit.weight)
    //     .reduce((a, b) => a + b)
    //     .toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail User',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Ditimbang Pada ${data.createdAt.toFormattedDateDayTimeString()}',
          //   style: Get.textTheme.titleSmall!.copyWith(
          //       fontSize: AppSizes.s10, color: AppColors.colorNeutrals500),
          // ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'KTP',
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: AppSizes.s16,
                ),
              ),
              Text(
                data.profile.identityNumber,
                style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSizes.s16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode User',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
              Text(
                data.profile.kdUser,
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
            ],
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Username',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.username,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
          AppSizes.s10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.status,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
          AppSizes.s10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama User',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.profile.name,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
          AppSizes.s10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alamat',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Container(
                width: 200,
                child: Text(
                  data.profile.address,
                  style: Get.textTheme.titleSmall!
                      .copyWith(fontSize: AppSizes.s14),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          AppSizes.s10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No Telp',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.profile.telp,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
        ],
      ).paddingAll(AppSizes.s20),
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
            if (data.status == 'INACTIVE') ...[
              AppSizes.s20.height,
              Button.filled(
                onPressed: () async {
                  // Get.to(EditDepositTrashScreen(
                  //   data: data,
                  // ));
                  controller.updateStatusDeposit(context, data.id);
                },
                label: 'Setujui Customer',
                borderRadius: AppSizes.s4,
              ),
              AppSizes.s12.height,
            ],
            if (data.status == 'ACTIVE') ...[
              AppSizes.s10.height,
              Button.outlined(
                onPressed: () async {
                  Get.to(EditRegisterScreen(
                    datas: data,
                  ));
                },
                label: 'Edit',
                borderRadius: AppSizes.s4,
              ),
              AppSizes.s10.height,
              Button.filled(
                onPressed: () async {
                  showDepositTrashSucces(
                      context: context,
                      icon: Assets.icons.phQuestion.path,
                      label: AppConstants.LABEL_DELETE_QUESTION,
                      firstButton: AppConstants.LABEL_NO,
                      fistOnPressed: () async {
                        Get.back();
                        Get.back();
                        //Get.toNamed(AppRoutes.priceTrash);
                      },
                      secondButton: AppConstants.LABEL_YES,
                      seccondOnPressed: () async {
                        // listTrash.clear();
                        // await getTrash();

                        await controller.deteleUserRegister(data.id);
                      },
                      showButton: true);
                },
                label: 'Delete',
                borderRadius: AppSizes.s4,
              ),
              AppSizes.s12.height,
            ],
          ],
        ),
      ),
    );
  }
}
