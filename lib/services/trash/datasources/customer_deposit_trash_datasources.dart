import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/post_deposit_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/customer/get_deposit_trash_update_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/post_deposit_trash_response.dart';

class CustomerDepositTrashDatasources extends ApiService {
  var token;

  Future<Either<Failure, DepositTrashResponse>> getCustomerDeposit() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);

    try {
      final response = await get(
          NetworkConstants.GET_CUSTOMER_DEPOSIT_TRASH_URL(userData['id']),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(DepositTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, e.toString()));
    }
  }

  Future<Either<Failure, DepositTrashResponse>> getSuperAdminDeposit() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_SUPER_ADMIN_DEPOSIT_TRASH_URL,
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(DepositTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, e.toString()));
    }
  }

  Future<Either<Failure, GetDepositTrashUpdateResponse>>
      postDepositStatusCustomer(PostUpdateStatusRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.PUT_STATUS_DEPOSIT_URL,
        data: {
          "summaryId": data.transactionId,
          "status": data.status,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );
      return Right(GetDepositTrashUpdateResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }

      Future<Either<Failure, PostDepositTrashResponse>> putDepositTrash(
      PostDepositTrashRequest data, String idSummary) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.PUT_DEPOSIT_SUPER_ADMIN_TRASH_URL(idSummary),
        data: {
          'userId': data.userId,
          'items': data.ItemTrsahs,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      print(response);
      return Right(PostDepositTrashResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }
}
