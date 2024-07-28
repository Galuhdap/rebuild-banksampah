import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_repository.dart';
import 'package:rebuild_bank_sampah/services/auth/model/request/login_request.dart';
import 'package:rebuild_bank_sampah/services/auth/model/response/get_login_response.dart';

class AuthRepository {
  final AuthDataSource source;

  AuthRepository(this.source);

  Future<Either<Failure, GetLoginResponse>> loginUser(
      LoginRequest loginRequest) async {
    return source.loginUser(loginRequest);
  }

  // Future<List<SettingEnumeratorResponse?>?> getSettingEnumerator() async {
  //   return source.getSettingEnumerator();
  // }

  // Future<Either<Failure, dynamic>> changePassword(
  //     ChangePasswordRequest changePasswordRequest, String token) async {
  //   return source.changePassword(changePasswordRequest, token);
  // }
}
