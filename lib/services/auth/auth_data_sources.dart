import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/login_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/register_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/delete_user_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_login_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_role_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_update_register_customer.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/post_register_response.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/get_message_error_response.dart';
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

  Future<Either<Failure, GetUserResponse>> getUserRegister() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_REGISTER_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetUserResponse.fromJson(response));
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

  Future<Either<Failure, PostUserRegisterResponse>> registerCustomer(
      RegisterRequest data) async {
    try {
      final response = await Dio().post(
        NetworkConstants.POST_REGISTER_CUSTOMER_URL,
        data: {
          "username": data.username,
          "password": data.password,
          "identityType": "KTP",
          "role": "CUSTOMER",
          "identityNumber": data.identityNumber,
          "name": data.name,
          "address": data.address,
          "telp": data.telp,
        },
      );

      print(response);

      return Right(PostUserRegisterResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
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
          "address": data.address,
          "telp": data.telp,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(PostUserRegisterResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }

  Future<Either<Failure, GetUpdateCustomerResponse>> updateRegister(
      RegisterRequest data, String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.UPDATE_REGISTER_URL(id),
        data: {
          "username": data.username,
          "name": data.name,
          "telp": data.telp,
          "address": data.address,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(GetUpdateCustomerResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data Tidak masuk'));
    }
  }

  Future<Either<Failure, DeleteUserResponse>> forgotPassword(
      String username, String newPassword) async {
    try {
      final response = await Dio().post(
        NetworkConstants.POST_FORGOT_PASSWORD_URL,
        data: {"username": username, "newPassword": newPassword},
      );

      return Right(DeleteUserResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data Tidak masuk'));
    }
  }

  Future<Either<Failure, DeleteUserResponse>> deletUserRegister(
      String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().delete(
        NetworkConstants.DELETE_REGISTER_URL(id),
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(DeleteUserResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data Tidak masuk'));
    }
  }

  Future<Either<Failure, GetErrorMessageResponse>> updateStatusRegister(
      {required String id}) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.PUT_STATUS_REGISTER_SUPER_URL,
        data: {"id": id, "status": "ACTIVE"},
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );
      return Right(GetErrorMessageResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }
}
