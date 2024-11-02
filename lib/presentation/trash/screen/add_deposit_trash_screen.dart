import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/component/input_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/deposit_trash_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_customer_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';

class AddDepositTrashScreen extends StatelessWidget {
  const AddDepositTrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DepositTrashController controller = Get.put(DepositTrashController());
    return WillPopScope(
      onWillPop: () async {
        // Kondisi yang diinginkan saat tombol back ditekan
        bool shouldNavigate = true; // Sesuaikan kondisinya

        if (shouldNavigate) {
          // Navigasi ke halaman home menggunakan Get.offAndToNamed
          // controller.weight.text = '';
          // controller.totalPriceTrash.value = 0;
          // controller.dropdownSearchFieldController.clear();
          // controller.selectedCustomerId.value = '';
          // controller.dropdownTrashController.clear();
          // controller.selectedTrashId.value = '';
          // controller.listTrash.clear();
          // controller.listCustomer.clear();
          // controller.listDepositTrash.clear();
          // controller.selectedTrashList.clear();
          Get.offAllNamed(AppRoutes.setorSampah);
          return false; // Mencegah pop langsung, kita kontrol manual navigasinya
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Setor Sampah',
            style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
          ),
          leading: IconButton(
            onPressed: () {
              controller.weight.text = '';
              controller.totalPriceTrash.value = 0;
              controller.dropdownSearchFieldController.clear();
              controller.selectedCustomerId.value = '';
              controller.dropdownTrashController.clear();
              controller.selectedTrashId.value = '';
              controller.listTrash.clear();
              controller.listCustomer.clear();
              controller.listDepositTrash.clear();
              controller.selectedTrashList.clear();
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
                  ? Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Lottie.asset(Assets.lottie.loadingLogin),
                      ),
                    )
                  : Button.filled(
                      onPressed: () async {
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
                        suggestion.profile.name,
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
                        suggestion.profile.name;
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
                    controller.addSelectedTrash(suggestion.id);
                    controller.weightControllers.add(TextEditingController());
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
            AppSizes.s20.height,
            Obx(() {
              return controller.selectedTrashList.isEmpty
                  ? Container(
                      padding:
                          AppSizes.symmetricPadding(vertical: AppSizes.s150),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Assets.images.emptyData.image(scale: 4),
                            Text(
                              'Data Kosong',
                              style: Get.textTheme.titleLarge!
                                  .copyWith(fontSize: AppSizes.s18),
                            ),
                            Text(
                              'Tidak ada data yang bisa ditampilkan sekarang.',
                              style: Get.textTheme.titleLarge!.copyWith(
                                  fontSize: AppSizes.s12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: AppSizes.setResponsiveHeight(context) * 0.5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.selectedTrashList.length,
                        itemBuilder: (context, index) {
                          var trash = controller.selectedTrashList[index];
                          return Container(
                            margin: AppSizes.symmetricPadding(
                                vertical: AppSizes.s10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trash.nama,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                      ),
                                    ),
                                    AppSizes.s12.height,
                                    Text(
                                      '${trash.harga.currencyFormatRp}/Kg',
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
                                        controller:
                                            controller.weightControllers[index],
                                        keyboardType: TextInputType.number,
                                        //textInputType: TextInputType.name,
                                        hintStyle: Get.textTheme.titleMedium!
                                            .copyWith(
                                                color:
                                                    AppColors.colorSecondary600,
                                                fontSize: AppSizes.s12),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            double weight =
                                                double.tryParse(value) ?? 0.0;
                                            // Update berat di controller
                                            // controller.updateTrashWeight(
                                            //     trash.id, value);
                                            controller.calculateTotal(weight);
                                          } else {
                                            // Reset jika kosong
                                            //controller.updateTrashWeight(trash.id, 0.0);
                                            controller.calculateTotal(0.0);
                                          }
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller
                                            .removeSelectedTrash(trash.id);
                                        controller.weightControllers
                                            .removeAt(index);
                                      },
                                      icon: Icon(Icons.clear_rounded),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
            }).paddingSymmetric(
              horizontal: AppSizes.s1,
            ),
            AppSizes.s20.height,
          ],
        ).paddingSymmetric(
          horizontal: AppSizes.s16,
        ),
      ),
    );
  }
}
