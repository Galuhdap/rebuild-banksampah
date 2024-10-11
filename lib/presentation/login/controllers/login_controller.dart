import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_repository.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/login_request.dart';

class LoginController extends GetxController {
  var isBusy = false.obs;

  final AuthRepository authRepository = locator();
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isloadingLogin = false.obs;

  Future<void> userLogin() async {
    isloadingLogin.value = true;
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      final userData = LoginRequest(
          username: usernameController.text, password: passwordController.text);
      var response = await authRepository.loginUser(userData);

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          await SharedPreferencesUtils.addUser(jsonEncode(response.toJson()));
          await SharedPreferencesUtils.addAuthToken(response.data.accessToken);
          Get.offAllNamed(AppRoutes.home);
        },
      );

      Future.delayed(
        Duration(seconds: 1),
        () {
          isloadingLogin.value = false;
        },
      );
    } catch (e) {
      print('e:$e');
      isloadingLogin.value = false;
    }
  }
}
