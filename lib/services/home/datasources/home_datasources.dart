import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_admin_koprasi_balanse_response.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_customer_balance_response.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_weigher_summary_response.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';

class HomeDatasources extends ApiService {

  Future<Either<Failure, GetCustomerBalanceResponse>> getBalanceCustomer() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);

    try {
      final response =
          await get(NetworkConstants.GET_CUSTOMER_BALANCE_URL(userData['id']), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetCustomerBalanceResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data Tidak masuk'));
    }
  }

  Future<Either<Failure, GetWeigherSummaryResponse>> getSummaryWeigher() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_SUMMARY_WEIGHET_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetWeigherSummaryResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data Tidak masuk'));
    }
  }

  Future<Either<Failure, GetBalanceAdminKoprasiResponse>> getSummaryAdminKoprasi() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_SUMMARY_ADMIN_KOPRASI_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetBalanceAdminKoprasiResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data Tidak masuk'));
    }
  }
}