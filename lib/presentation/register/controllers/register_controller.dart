import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/register/screen/loading_delete_register_screen.dart';
import 'package:rebuild_bank_sampah/presentation/register/screen/loading_edit_register_screen.dart';
import 'package:rebuild_bank_sampah/presentation/register/screen/loading_register_screen.dart';
import 'package:rebuild_bank_sampah/presentation/register/screen/loading_status_register_screen.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_repository.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/register_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_role_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';

class RegisterController extends GetxController {
  final AuthRepository authRepository = locator();

  final TextEditingController searchRegisterUser = TextEditingController();
  final TextEditingController dropdownSearchFieldController =
      TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController noKtpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController telpController = TextEditingController();

  RxString searchQuery = "".obs;
  RxBool isLoadingUser = false.obs;
  RxBool isLoadingRole = false.obs;
  RxBool isLoadingDeleteUser = false.obs;
  RxBool isLoadingAddUser = false.obs;
  RxBool isLoadingUpdateUser = false.obs;
  RxBool isLoadingUpdateStatusUser = false.obs;
  RxInt activeButtonIndex = 0.obs;

  RxList<UserData> listUserRegister = <UserData>[].obs;
  RxList<UserData> searchUserRegister = <UserData>[].obs;

  RxList<RoleData> listRoleUser = <RoleData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
    getRole();
  }

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }

  Future<void> getUser() async {
    isLoadingUser.value = true;
    try {
      final response = await authRepository.getUserRegister();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listUserRegister.addAll(response.data);
        },
      );
      isLoadingUser.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingUser.value = false;
    }
  }

  Future<void> getRole() async {
    isLoadingRole.value = true;
    try {
      final response = await authRepository.getRoleRegister();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listRoleUser.addAll(response.data);
        },
      );
      isLoadingRole.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingRole.value = false;
    }
  }

  Future<void> postDepositTrash(BuildContext context) async {
    isLoadingAddUser.value = true;
    try {
      final data = RegisterRequest(
          username: usernameController.text,
          password: passwordController.text,
          name: nameController.text,
          identityType: 'KTP',
          identityNumber: noKtpController.text,
          address: alamatController.text,
          role: dropdownSearchFieldController.text,
          telp: telpController.text);

      final response = await authRepository.postRegister(data);

      response.fold(
        (response) {
          MessageComponent.snackbar(
            title: '${response.code}',
            message: response.message,
            isError: true,
          );
          update();
        },
        (response) async {
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'User added successfully',
            isError: false,
          );
          Get.to(LoadingRegisterScreen(
            label: AppConstants.LABEL_REGISTER_SUCCES,
          ));
          nameController.text = '';
          alamatController.text = '';
          noKtpController.text = '';
          telpController.text = '';
          usernameController.text = '';
          passwordController.text = '';
          dropdownSearchFieldController.clear();
          searchUserRegister.clear();
          listUserRegister.clear();
          await getUser();
          await getRole();

          update();
        },
      );

      isLoadingAddUser.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingAddUser.value = false;
    }
  }

  Future<void> editRegister(RegisterRequest data, String id) async {
    isLoadingUpdateUser.value = true;
    try {
      final response = await authRepository.updateRegister(data, id);

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
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'User edit successfully',
            isError: false,
          );
          Get.to(LoadingEditRegisterScreen(
            label: 'Edit Data Berhasil',
          ));
          nameController.text = '';
          alamatController.text = '';
          noKtpController.text = '';
          telpController.text = '';
          usernameController.text = '';
          passwordController.text = '';
          dropdownSearchFieldController.clear();
          searchUserRegister.clear();
          listUserRegister.clear();
          await getUser();
          await getRole();

          update();
        },
      );

      isLoadingUpdateUser.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingUpdateUser.value = false;
    }
  }

  Future<void> deteleUserRegister(String id) async {
    isLoadingDeleteUser.value = true;
    try {
      final response = await authRepository.deleteUserRegister(id);

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
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'User Delete successfully',
            isError: false,
          );
          Get.to(LoadingDeleteRegisterScreen(
            label: 'Sukses Hapus User',
          ));
          nameController.text = '';
          alamatController.text = '';
          noKtpController.text = '';
          usernameController.text = '';
          passwordController.text = '';
          formKey.currentState?.reset();
          dropdownSearchFieldController.clear();
          listUserRegister.clear();
          await getUser();
          await getRole();
          update();
        },
      );

      isLoadingDeleteUser.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingDeleteUser.value = false;
    }
  }

  void filterSearchTrash() {
    if (searchQuery.value.isEmpty) {
      searchUserRegister.assignAll(listUserRegister);
    } else {
      searchUserRegister.assignAll(
        listUserRegister.where((data) {
          return data.username
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }

  List<RoleData> getSuggestions(String query) {
    return listRoleUser
        .where((customer) =>
            customer.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void filterSearchRegister() {
    if (searchQuery.value.isEmpty) {
      List<UserData> filteredOrders = listUserRegister.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchUserRegister.assignAll(filteredOrders);
    } else {
      List<UserData> filteredOrders = listUserRegister.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchUserRegister.assignAll(
        filteredOrders.where((data) {
          return data.profile.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }

  Future<void> updateStatusDeposit(BuildContext context, String id) async {
    isLoadingUpdateStatusUser.value = true;
    try {
      final response = await authRepository.updateStatusRegister(id: id);

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
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'User Active',
            isError: false,
          );
          Get.to(LoadingStatusRegisterScreen(
            label: 'Customer Telah Active',
          ));
          listUserRegister.clear();
          await getUser();
          update();
        },
      );

      isLoadingUpdateStatusUser.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingUpdateStatusUser.value = false;
    }
  }
}
