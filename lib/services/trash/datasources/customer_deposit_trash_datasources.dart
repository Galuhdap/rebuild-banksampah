import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/customer/get_deposit_customer_trash_response.dart';

class CustomerDepositTrashDatasources extends ApiService {
  var token;

  Future<Either<Failure, GetCustomerDepositTrashResponse>> getCustomerDeposit() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);

    try {
      final response =
          await get(NetworkConstants.GET_CUSTOMER_DEPOSIT_TRASH_URL(userData['id']), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetCustomerDepositTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'dataaaaa Tidak masuk'));
    }
  }

}
