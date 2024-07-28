import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkUserData();
  }

  void checkUserData() async {
    await Future.delayed(Duration(seconds: 2));
    final prefs = await SharedPreferencesUtils.getAuthToken();
    if (prefs != null) {
      Get.toNamed('/home');
    } else {
      Get.toNamed('/login');
    }
  }
}
