import 'dart:developer';

import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/lib/sql_lite_db_services.dart';
import 'package:rebuild_bank_sampah/services/profile/model/get_profile_response.dart';
import 'package:rebuild_bank_sampah/services/profile/repository/profile%20_data_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProfileController extends GetxController {
  final ProfileDataRepository repository = locator();

  Rxn<ProfileData?> profile = Rxn<ProfileData?>(null);
  // var profiles = Rxn<Profile>();
  RxBool isLoadingProfile = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoadingProfile.value = true;
    try {
      final response = await repository.getProfile();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          profile.value = response.data;
        },
      );
      isLoadingProfile.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingProfile.value = false;
    }
  }

  Future<void> removeItem() async {
    final Database database = await DatabaseService().database();

    await database.delete(
      'fava',
    );

    update();
  }
}
