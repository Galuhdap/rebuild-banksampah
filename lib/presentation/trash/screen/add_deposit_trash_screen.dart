import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/deposit_trash_controller.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/loading_trash_screen.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_customer_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';

class AddDepositTrashScreen extends StatelessWidget {
  const AddDepositTrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DepositTrashController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setor Sampah',
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
            return controller.isloadingAddDepositTrash.value
                ? Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Button.filled(
                    onPressed: () async {
                      Get.to(LoadingTrashScreen());
                      await controller.postDepositTrash(context);
                    },
                    label: AppConstants.ACTION_DEPOSIT,
                  );
          })),
      body: ListView(
        children: [
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
              DropDownSearchFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintText: 'Pilih Nasabah',
                    suffixIcon: Icon(Iconsax.arrow_down_1),
                    hintStyle: Get.textTheme.titleMedium!.copyWith(
                        color: AppColors.colorSecondary600,
                        fontSize: AppSizes.s15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                      borderSide: BorderSide(
                        color: AppColors.colorSecondary400,
                        width: AppSizes.s1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                      borderSide: BorderSide(
                          color: AppColors.colorSecondary400,
                          width: AppSizes.s2),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: AppSizes.s16,
                    color: Colors.black,
                  ),
                  controller: controller.dropdownSearchFieldController,
                ),
                suggestionsCallback: (pattern) {
                  return controller.getSuggestions(pattern);
                },
                itemBuilder: (context, Customer suggestion) {
                  return ListTile(
                    title: Text(
                      suggestion.username,
                      style: TextStyle(
                        fontSize: AppSizes.s16,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                itemSeparatorBuilder: (context, index) {
                  return const Divider();
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (Customer suggestion) {
                  controller.dropdownSearchFieldController.text =
                      suggestion.username;
                  controller.selectedCustomerId.value = suggestion.id;
                },
                suggestionsBoxController: controller.suggestionBoxController,
                validator: (value) =>
                    value!.isEmpty ? 'Please select a customer' : null,
                onSaved: (value) {},
                displayAllSuggestionWhenTap: true,
              ),
              // Obx(() => Text(
              //     'ID Nasabah yang dipilih: ${controller.selectedCustomerId.value}')),
            ],
          ),
          AppSizes.s20.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConstants.LABEL_TYPE_TRASH,
                style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s12,
                ),
              ),
              AppSizes.s10.height,
              DropDownSearchFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintText: 'Pilih Jenis Sampah',
                    suffixIcon: Icon(Iconsax.arrow_down_1),
                    hintStyle: Get.textTheme.titleMedium!.copyWith(
                        color: AppColors.colorSecondary600,
                        fontSize: AppSizes.s15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                      borderSide: BorderSide(
                        color: AppColors.colorSecondary400,
                        width: AppSizes.s1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                      borderSide: BorderSide(
                          color: AppColors.colorSecondary400,
                          width: AppSizes.s2),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: AppSizes.s16,
                    color: Colors.black,
                  ),
                  controller: controller.dropdownTrashController,
                ),
                suggestionsCallback: (pattern) {
                  return controller.getTrashSuggestions(pattern);
                },
                itemBuilder: (context, GroupTrash suggestion) {
                  return ListTile(
                    title: Text(
                      suggestion.nama,
                      style: TextStyle(
                        fontSize: AppSizes.s16,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                itemSeparatorBuilder: (context, index) {
                  return const Divider();
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (GroupTrash suggestion) {
                  controller.dropdownTrashController.text = suggestion.nama;
                  controller.selectedTrashId.value = suggestion.id;
                  controller.setPriceTrashValue(suggestion.id);
                },
                suggestionsBoxController: controller.suggestionBoxController,
                validator: (value) =>
                    value!.isEmpty ? 'Please select a Jenis Sampah' : null,
                onSaved: (value) {},
                displayAllSuggestionWhenTap: true,
              ),
              // Obx(() => Text(
              //     'ID Jenis Sampah yang dipilih: ${controller.selectedTrashId.value}')),
            ],
          ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       AppConstants.LABEL_TYPE_TRASH,
          //       style: Get.textTheme.labelLarge!.copyWith(
          //         fontSize: AppSizes.s12,
          //       ),
          //     ),
          //     AppSizes.s10.height,
          //     Obx(() {
          //       return Container(
          //         padding: AppSizes.symmetricPadding(
          //             vertical: AppSizes.s5, horizontal: AppSizes.s15),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(AppSizes.s10),
          //             border: Border.all(
          //                 color: AppColors.colorSecondary400,
          //                 width: AppSizes.s1)),
          //         child: DropdownButton<String>(
          //           value: controller.selectedTrashId.value,
          //           menuMaxHeight: AppSizes.setResponsiveWidth(context),
          //           underline: SizedBox.shrink(),
          //           icon: Icon(
          //             Icons.keyboard_arrow_down,
          //             weight: AppSizes.s20,
          //             size: AppSizes.s30,
          //             color: ThemeConfig.neutral0,
          //           ),
          //           iconSize: AppSizes.s24,
          //           elevation: 2,
          //           isExpanded: true,
          //           style:
          //               ThemeConfig.labelMedium.copyWith(color: Colors.black),
          //           items: controller.listTrash
          //               .map<DropdownMenuItem<String>>((GroupTrash trash) {
          //             return DropdownMenuItem<String>(
          //               value: trash.id,
          //               child: Text(trash.nama),
          //             );
          //           }).toList(),
          //           onChanged: (Object? value) {
          //             if (value != null && value is String) {
          //               controller.setDropdownValue(value);
          //               // var selectedTrash = controller.listTrash.firstWhere(
          //               //   (trash) => trash.id == value,
          //               // );

          //               // if (selectedTrash != null) {
          //               //   int harga = selectedTrash.harga;
          //               //   print("Harga: $harga");
          //               //   // Simpan atau gunakan harga sesuai kebutuhan
          //               // }
          //               controller.setPriceTrashValue(value);

          //               // controller.getCommodityChartDaily();
          //             }
          //           },
          //         ),
          //       );
          //     }),
          //   ],
          // ),
          AppSizes.s20.height,
          Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppConstants.LABEL_PRICE,
                    style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12,
                    ),
                  ),
                  Text(
                    controller.priceTrash.value.toInt().currencyFormatRp,
                    style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12,
                    ),
                  ),
                ],
              );
            },
          ),
          AppSizes.s20.height,
          InputWidget(
            label: AppConstants.LABEL_WEIGHT,
            hintText: AppConstants.LABEL_WEIGHT,
            controller: controller.weight,
            textInputType: TextInputType.name,
            hintStyle: Get.textTheme.titleMedium!.copyWith(
                color: AppColors.colorSecondary600, fontSize: AppSizes.s12),
            onChanged: (value) {
              if (value.isNotEmpty) {
                double weight = double.tryParse(value) ?? 0.0;
                controller.calculateTotal(weight);
              } else {
                controller.calculateTotal(0.0);
              }
            },
          ),
          AppSizes.s20.height,
          Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Rupiah yang didapatkan : ',
                    style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12,
                    ),
                  ),
                  Text(
                    controller.totalPriceTrash.value.toInt().currencyFormatRp,
                    style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12,
                    ),
                  ),
                ],
              );
            },
          ),
          AppSizes.s20.height,
        ],
      ).paddingSymmetric(
        horizontal: AppSizes.s16,
      ),
    );
  }
}
