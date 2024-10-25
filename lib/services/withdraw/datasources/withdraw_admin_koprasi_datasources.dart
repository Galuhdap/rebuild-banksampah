import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/status_withdraw_super_admin.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/withdraw_admin_koprasi_request.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/post_withdraw_admin_koprasi_response.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/post_withdraw_status_admin_koprasi.dart';

class WithdrawAdminKoprasiDatasources extends ApiService {
  Future<Either<Failure, GetWithdarawAdminKoprasiResponse>>
      getWithdarawAdminKoprasi() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_WITHDRAW_ADMIN_KOPRASI_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      print(response);

      return Right(GetWithdarawAdminKoprasiResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, e.toString()));
    }
  }

  Future<Either<Failure, PostWithdarawAdminKoprasiResponse>>
      postWithdrawAdminKoprasi(WithdrawAdminKoprasiRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().post(
        NetworkConstants.POST_WITHDRAW_URL,
        data: {
          "name_admin": data.nameAdmin,
          "name_coop": data.nameCoop,
          "nominal": data.nominal
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(PostWithdarawAdminKoprasiResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }

  Future<Either<Failure, PostWithdrawResponse>> postWithdrawStatusAdminKoprasi(
      PostUpdateStatusWithdrawRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.POST_STATUS_ADMIN_WITHDRAW_URL,
        data: {
          "id": data.id,
          "status": data.status,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );
      
      return Right(PostWithdrawResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }
}
