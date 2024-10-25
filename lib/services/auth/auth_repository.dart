import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_data_sources.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/login_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/register_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/delete_user_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_login_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_role_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_update_register_customer.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_user_response.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/post_register_response.dart';

class AuthRepository {
  final AuthDataSource source;

  AuthRepository(this.source);

  Future<Either<Failure, GetLoginResponse>> loginUser(
      LoginRequest loginRequest) async {
    return source.loginUser(loginRequest);
  }

  Future<Either<Failure, GetUserResponse>> getUserRegister() async {
    return source.getUserRegister();
  }

  Future<Either<Failure, PostUserRegisterResponse>> postRegister(
      RegisterRequest data) async {
    return source.postRegister(data);
  }

  Future<Either<Failure, GetUpdateCustomerResponse>> updateRegister(
      RegisterRequest data, String id) async {
    return source.updateRegister(data, id);
  }

  Future<Either<Failure, GetRoleResponse>> getRoleRegister() async {
    return source.getRoleRegister();
  }

  Future<Either<Failure, DeleteUserResponse>> deleteUserRegister(String id) async {
    return source.deletUserRegister(id);
  }

  Future<Either<Failure, DeleteUserResponse>> forgotPassword(String userName, String newPassword) async {
    return source.forgotPassword(userName, newPassword);
  }

  // Future<List<SettingEnumeratorResponse?>?> getSettingEnumerator() async {
  //   return source.getSettingEnumerator();
  // }

  // Future<Either<Failure, dynamic>> changePassword(
  //     ChangePasswordRequest changePasswordRequest, String token) async {
  //   return source.changePassword(changePasswordRequest, token);
  // }
}
