import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/component/input_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/deposit_trash_super_admin_controller.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/post_deposit_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';

class EditDepositTrashSuperAdminScreen extends StatelessWidget {
  final DepositTrash data;
  const EditDepositTrashSuperAdminScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    DepositTrashSuperAdminController controller =
        Get.put(DepositTrashSuperAdminController());
    controller.initializeControllers(data.deposits);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Setor Sampah Super Admin',
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
      bottomNavigationBar: Container(
          padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s16, horizontal: AppSizes.s16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -2),
                blurRadius: 30.0,
                blurStyle: BlurStyle.outer,
                spreadRadius: 0,
                color: AppColors.colorBaseBlack.withOpacity(0.08),
              ),
            ],
          ),
          child: Obx(() {
            return controller.isloadingPutDepositTrash.value
                ? Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Button.filled(
                    onPressed: () async {
                      List<ItemTrsah> datas = [];
                      print(datas);
                      for (int i = 0; i < controller.controllers.length; i++) {
                        String weightText = controller.controllers[i].text;
                        double weight =
                            double.tryParse(weightText) ?? 0.0; // Parsing berat

                        if (weight > 0) {
                          // Pastikan berat lebih dari 0 sebelum menambahkannya ke daftar
                          ItemTrsah item = ItemTrsah(
                            trashId: data.deposits[i].trashId,
                            weight: weight,
                          );
                          datas.add(item);
                        }
                      }

                      await controller.putDepositTrash(
                          context, data.summaryId, data.user.id, datas);
                    },
                    label: AppConstants.ACTION_DEPOSIT,
                  );
          })),
      body: ListView(children: [
        AppSizes.s10.height,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nasabah',
              style: Get.textTheme.labelLarge!.copyWith(
                fontSize: AppSizes.s12,
              ),
            ),
            AppSizes.s10.height,
            Text(
              data.user.profile.name,
              style: Get.textTheme.labelLarge!.copyWith(
                fontSize: AppSizes.s16,
              ),
            ),
            AppSizes.s20.height,
            SizedBox(
              width: double.infinity,
              height: AppSizes.setResponsiveHeight(context) * 0.5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.deposits.length,
                itemBuilder: (context, index) {
                  var trash = data.deposits[index];
                  // TextEditingController controllerWeight =
                  //     TextEditingController(text: trash.weight.toString());
                  // controllers.add(controllerWeight);
                  // print(controllers);
                  return Container(
                    margin: AppSizes.symmetricPadding(vertical: AppSizes.s10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              toBeginningOfSentenceCase(trash.trashName),
                              style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSizes.s14,
                              ),
                            ),
                            AppSizes.s12.height,
                            Text(
                              '${trash.nominal.currencyFormatRp}/Kg',
                              style: Get.textTheme.bodySmall!.copyWith(
                                fontSize: AppSizes.s14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              child: CustomTextField(
                                hintText: AppConstants.LABEL_WEIGHT,
                                controller: controller.controllers[index],
                                keyboardType: TextInputType.number,
                                //textInputType: TextInputType.name,
                                hintStyle: Get.textTheme.titleMedium!.copyWith(
                                    color: AppColors.colorSecondary600,
                                    fontSize: AppSizes.s12),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    // controllers.clear();
                                    // double weight =
                                    //     double.tryParse(value) ?? 0.0;
                                  } else {
                                    // Reset jika kosong
                                    //controller.updateTrashWeight(trash.id, 0.0);
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ).paddingSymmetric(
              horizontal: AppSizes.s1,
            ),
            AppSizes.s20.height,
          ],
        ).paddingSymmetric(
          horizontal: AppSizes.s16,
        ),
      ]),
    );
  }
}
