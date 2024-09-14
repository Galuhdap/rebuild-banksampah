
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';

class HomeController extends GetxController {
  RxString role = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    checkUserData();
    super.onInit();
  }

  void checkUserData() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferencesUtils.getAuthToken();
      var userData = JwtDecoder.decode(prefs!);
      role.value = userData['role'];
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }
}
