import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
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

  RxString searchQuery = "".obs;
  RxBool isLoadingUser = false.obs;
  RxBool isLoadingDeleteUser = false.obs;
  RxBool isLoadingAddUser = false.obs;

  RxList<UserData> listUserRegister = <UserData>[].obs;
  RxList<UserData> searchUserRegister = <UserData>[].obs;

  RxList<RoleData> listRoleUser = <RoleData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
    getRole();
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
    isLoadingUser.value = true;
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
      isLoadingUser.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingUser.value = false;
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
      );

      final response = await authRepository.postRegister(data);

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
            message: 'User added successfully',
            isError: false,
          );
          showDepositTrashSucces(
              context: context,
              icon: Assets.icons.succes.path,
              label: AppConstants.LABEL_REGISTER_SUCCES,
              firstButton: AppConstants.LABEL_SEE_HISTORY,
              fistOnPressed: () async {
                listUserRegister.clear();
                await getUser();
                Get.back();
                Get.back();
              },
              // secondButton: AppConstants.LABEL_BERANDA,
              // seccondOnPressed: () async {
              //   listDepositTrash.clear();
              //   await getDepositTrash();
              //   Get.offAllNamed(AppRoutes.home);
              // },
              showButton: false);

          update();
        },
      );

      isLoadingAddUser.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingAddUser.value = false;
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
}
