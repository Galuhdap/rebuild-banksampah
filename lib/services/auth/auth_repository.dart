import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/login_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_login_response.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';

class AuthDataSource extends ApiService {
  var token;

  Future<Either<Failure, GetLoginResponse>> loginUser(
      LoginRequest loginRequest) async {
    final response =
        await post(NetworkConstants.POST_LOGIN_URL, body: loginRequest.toJson());

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(GetLoginResponse.fromJson(response)),
    );
  }

  // Future<List<SettingEnumeratorResponse?>?> getSettingEnumerator() async {
  //   token = (await PreferencesUtils.getAuthToken())!;

  //   final response = await get(NetworkConstants.SETTING_ENUMERATOR_URL,
  //       header: {'Authorization': token});

  //   if (response is List) {
  //     return response
  //         .map((json) => SettingEnumeratorResponse.fromJson(json as Map<String, dynamic>))
  //         .toList();
  //   } else {
  //     throw Exception("Unexpected response format");
  //   }
  // }

  // Future<Either<Failure, dynamic>> changePassword(
  //   ChangePasswordRequest changePasswordRequest,
  //   String token,
  // ) async {
  //   final response = await post(NetworkConstants.CHANGE_PASSWORD_URL,
  //       header: {'Authorization': token}, body: changePasswordRequest.toJson());

  //   return response.fold(
  //     (failure) => Left(failure),
  //     (response) => Right(response),
  //   );
  // }
}
