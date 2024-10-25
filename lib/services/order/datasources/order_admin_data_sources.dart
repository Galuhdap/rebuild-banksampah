import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_admin_response.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_admin_status_response.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_customer_response.dart';

class OrderAdminDataSources extends ApiService {
  Future<Either<Failure, GetOrderAdminResponse>> getOrder() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_ORDER_ADMIN_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });
      return Right(GetOrderAdminResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetOrderCustomerResponse>> getOrderCustomer() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);

    try {
      final response = await get(
          NetworkConstants.GET_ORDER_CUSTOMER_URL(userData['id']),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });
      return Right(GetOrderCustomerResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetOrderAdminStatusResponse>> postOrderStatusAdmin(
      PostUpdateStatusRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.POST_ORDER_ADMIN_URL,
        data: {
          "transactionId": data.transactionId,
          "status": data.status,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );
      return Right(GetOrderAdminStatusResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data masuk'));
    }
  }

  Future<Either<Failure, GetOrderAdminStatusResponse>> postOrderStatusCustomer(
      PostUpdateStatusRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.POST_STATUS_CUSTOMER_ORDER_URL,
        data: {
          "transactionId": data.transactionId,
          "status": data.status,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );
      return Right(GetOrderAdminStatusResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data masuk'));
    }
  }
}
