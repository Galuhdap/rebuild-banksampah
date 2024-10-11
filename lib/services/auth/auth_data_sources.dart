import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/login_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/register_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_login_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_role_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/post_register_response.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';

class AuthDataSource extends ApiService {
  var token;

  Future<Either<Failure, GetLoginResponse>> loginUser(
      LoginRequest loginRequest) async {
    final response = await post(NetworkConstants.POST_LOGIN_URL,
        body: loginRequest.toJson());

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(GetLoginResponse.fromJson(response)),
    );
  }

  Future<Either<Failure, PosUserResponse>> getUserRegister() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_REGISTER_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(PosUserResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'Data tidak masuk'));
    }
  }
  
  Future<Either<Failure, GetRoleResponse>> getRoleRegister() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_ROLE_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetRoleResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'Data tidak masuk'));
    }
  }

  Future<Either<Failure, PostUserRegisterResponse>> postRegister(
      RegisterRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().post(
        NetworkConstants.POST_REGISTER_URL,
        data: {
          "username": data.username,
          "password": data.password,
          "identityType": "KTP",
          "role": data.role,
          "identityNumber": data.identityNumber,
          "name": data.name,
          "address": data.password
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(PostUserRegisterResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data Tidak masuk'));
    }
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
