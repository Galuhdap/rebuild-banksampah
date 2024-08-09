import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class SplashController extends GetxController {
 // RxString role = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkUserData();
  }

  void checkUserData() async {
    await Future.delayed(Duration(seconds: 2));
    final prefs = await SharedPreferencesUtils.getAuthToken();
    if (prefs != null) {
      // Get.put(HomeController());
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

}
