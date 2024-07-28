import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';

class HomeController extends GetxController {
  RxString role = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    checkUserData();
    super.onInit();
  }

  void checkUserData() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    var userData = JwtDecoder.decode(prefs!);
    print( userData['role']);
    role.value = userData['role'];
  }
}
