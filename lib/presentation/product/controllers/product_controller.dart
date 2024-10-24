import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/product/screen/loading_add_product_screen.dart';
import 'package:rebuild_bank_sampah/presentation/product/screen/loading_edit_product_screen.dart';
import 'package:rebuild_bank_sampah/services/product/model/request/product_request.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';
import 'package:rebuild_bank_sampah/services/product/repository/product_data_repository.dart';

class ProductController extends GetxController {
  final ProductDataRepository productDataRepository = locator();
  final formKey = GlobalKey<FormState>();

  final nameProductController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final TextEditingController searchProduct = TextEditingController();

  Rxn<XFile?> selectedImage = Rxn<XFile?>();

  RxList<Product> listProduct = <Product>[].obs;
  RxList<Product> searchListProduct = <Product>[].obs;
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingAddProduct = false.obs;
  RxBool isLoadingEditProduct = false.obs;

  RxString searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  @override
  void onClose() {
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
      String inputText = priceController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final productData = ProductRequest(
        name: nameProductController.text,
        price: int.parse(inputText),
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

          update();
        },
        (response) async {
          MessageComponent.snackbar(
            title: 'Success',
            message: 'Product added successfully',
            isError: false,
          );
          Get.to(LoadingPostProductScreen());
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

  Future<void> putProduct(
    ProductRequest data,
    String id,
  ) async {
    isLoadingEditProduct.value = true;
    try {
      final response = await productDataRepository.putProduct(data, id);

      response.fold(
        (failure) {
          MessageComponent.snackbar(
            title: '${failure.code}',
            message: failure.message,
            isError: true,
          );

          update();
        },
        (response) async {
          MessageComponent.snackbar(
            title: 'Success',
            message: 'Product Edit successfully',
            isError: false,
          );
          Get.to(LoadingEditProductScreen());
          listProduct.clear();
          await getProduct();
          update();
        },
      );

      isLoadingEditProduct.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingEditProduct.value = false;
    }
  }

  void filterSearchTrash() {
    if (searchQuery.value.isEmpty) {
      searchListProduct.assignAll(listProduct);
    } else {
      searchListProduct.assignAll(
        listProduct.where((data) {
          return data.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }


}
