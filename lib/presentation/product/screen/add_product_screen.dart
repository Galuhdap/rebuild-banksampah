import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/helpers/validation_helper.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/product/controllers/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tambah Product',
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
            AppSizes.s20.height,
            Obx(
              () {
                return InkWell(
                  onTap: () {
                    controller.pickImageFromGallerry();
                  },
                  child: controller.selectedImage.value != null
                      ? Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                padding: AppSizes.symmetricPadding(
                                    vertical: AppSizes.s10,
                                    horizontal: AppSizes.s8),
                                child: Image.file(
                                  File(controller.selectedImage.value!.path),
                                ),
                              ),
                              Positioned(
                                  child: Container(
                                padding: AppSizes.allPadding(AppSizes.s3),
                                decoration: BoxDecoration(
                                  color: AppColors.colorBasePrimary,
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.s20),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: AppColors.colorBaseWhite,
                                ),
                              )),
                            ],
                          ),
                        )
                      : Assets.images.imageProductAdd.image(scale: 4),
                );
              },
            ),
            AppSizes.s30.height,
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  InputWidget(
                    label: AppConstants.LABEL_NAME_PRODUK,
                    hintText: AppConstants.LABEL_INPUT_NAME_PRODUK,
                    controller: controller.nameProductController,
                    textInputType: TextInputType.name,
                    validator: emptyValidation,
                  ),
                  AppSizes.s20.height,
                  InputWidget(
                    label: AppConstants.LABEL_PRICE_PRODUK,
                    hintText: AppConstants.LABEL_INPUT_PRICE_PRODUK,
                    controller: controller.priceController,
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ),
                    ],
                    validator: emptyValidation,
                  ),
                  AppSizes.s20.height,
                  InputWidget(
                    label: AppConstants.LABEL_STOCK_PRODUK,
                    hintText: AppConstants.LABEL_INPUT_STOCK_PRODUK,
                    controller: controller.stockController,
                    textInputType: TextInputType.number,
                    validator: emptyValidation,
                  ),
                ],
              ),
            ),
            AppSizes.s40.height,
            Obx(() {
              return controller.isLoadingAddProduct.value
                  ? Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Lottie.asset(Assets.lottie.loadingLogin),
                      ),
                    )
                  : Button.filled(
                      onPressed: () async {
                        await controller.postProduct();
                      },
                      label: 'Simpan');
            })
          ],
        ).paddingSymmetric(
          horizontal: AppSizes.s20,
        ));
  }

  void modalPicture(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.colorBaseWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            return FractionallySizedBox(
              heightFactor: 0.35,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.s24, vertical: AppSizes.s16),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 8,
                      height: AppSizes.s8,
                      decoration: const BoxDecoration(
                          color: AppColors.colorNeutrals300,
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                    SizedBox(
                      height: AppSizes.s30,
                    ),
                    Text(
                      'edit_photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.s35,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              // final ImagePicker _picker = ImagePicker();

                              // // Capture a photo
                              // final XFile? photo = await _picker.pickImage(
                              //     source: ImageSource.camera);
                              // if (photo != null) {
                              //   setState(() {
                              //     File retImage = File(photo.path);
                              //     _tempPhoto = retImage;
                              //   });
                              // }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                Text(
                                  'take_photo',
                                ),
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                const Divider(
                                  color: AppColors.colorNeutrals300,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);

                              // Pick an image
                              // FilePickerResult? result =
                              //     await FilePicker.platform.pickFiles(
                              //   type: FileType.image,
                              // );
                              // if (result != null) {
                              //   setState(() {
                              //     _tempPhoto = File(result.files.single.path!);
                              //   });
                              // }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                Text(
                                  'choose_gallery',
                                ),
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                const Divider(
                                  color: AppColors.colorNeutrals300,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
