import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/profile/model/get_profile_response.dart';

class ProfileDataSources extends ApiService {
  Future<Either<Failure, GetProfileResponse>> getProfile() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);

    try {
      final response = await get(
          NetworkConstants.GET_PROFILE_CUSTOMER_URL(userData['id']),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetProfileResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data Tidak masuk'));
    }
  }
}
