import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/post_deposit_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/customer/get_deposit_customer_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/delete_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_customer_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/post_deposit_trash_response.dart';

class DepositTrashDataSources extends ApiService {
  var token;

    Future<Either<Failure, GetCustomerDepositTrashResponse>> getCustomerDeposit() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_CUSTOMER_DEPOSIT_TRASH_URL('db8f818e-34c7-484c-8bbf-683e56ee04e2'), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetCustomerDepositTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'datarr Tidak masuk'));
    }
  }

  Future<Either<Failure, DepositTrashResponse>> getDepositTrash() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_DEPOSIT_TRASH_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(DepositTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, e.toString()));
    }
  }

  Future<Either<Failure, CustomerDepositTrashResponse>>
      getCustomerDepositTrash() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_USER_DEPOSIT_TRASH_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(CustomerDepositTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, e.toString()));
    }
  }

  Future<Either<Failure, DeleteDepositTrashResponse>> deleteDepositTrash(
      String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().delete(
        NetworkConstants.DELETE_DEPOSIT_TRASH_URL(id),
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(DeleteDepositTrashResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }

    Future<Either<Failure, PostDepositTrashResponse>> postDepositTrash(
      PostDepositTrashRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().post(
        NetworkConstants.POST_DEPOSIT_TRASH_URL,
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
      return Right(PostDepositTrashResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, e.toString()));
    }
  }

    Future<Either<Failure, PostDepositTrashResponse>> putDepositTrash(
      PostDepositTrashRequest data, String idSummary) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.PUT_DEPOSIT_TRASH_URL(idSummary),
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
