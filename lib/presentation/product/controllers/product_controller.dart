import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/product/model/request/product_request.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';
import 'package:rebuild_bank_sampah/services/product/repository/product_data_repository.dart';

class ProductController extends GetxController {
  final ProductDataRepository productDataRepository = locator();
  final formKey = GlobalKey<FormState>();

  final nameProductController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  Rxn<XFile> selectedImage = Rxn<XFile>();

  RxList<Product> listProduct = <Product>[].obs;
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingAddProduct = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  @override
  void onClose() {
    listProduct.clear(); // Bersihkan state saat controller di-close
    super.onClose();
  }

  Future<void> getProduct() async {
    isLoadingProduct.value = true;
    try {
      final response = await productDataRepository.getProduct();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listProduct.addAll(response.data);
          update();
        },
      );
      isLoadingProduct.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingProduct.value = false;
    }
  }

  void pickImageFromGallerry() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> postProduct() async {
    isLoadingAddProduct.value = true;
    try {
      final productData = ProductRequest(
        name: nameProductController.text,
        price: int.parse(priceController.text),
        stock: int.parse(stockController.text),
        image: File(selectedImage.value!.path),
      );

      final response = await productDataRepository.postProduct(productData);

      response.fold(
        (failure) {
          MessageComponent.snackbar(
            title: '${failure.code}',
            message: failure.message,
            isError: true,
          );
          Get.back();
          update();
        },
        (response) async {
          MessageComponent.snackbar(
            title: 'Success',
            message: 'Product added successfully',
            isError: false,
          );
          listProduct.clear();
          await getProduct();
          update();
        },
      );

      isLoadingAddProduct.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingAddProduct.value = false;
    }
  }
}
