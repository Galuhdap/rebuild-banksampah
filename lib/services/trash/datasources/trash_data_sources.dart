import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/price_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/delete_price_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/post_trash_response.dart';

class TrashDataSources extends ApiService {
  var token;

  Future<Either<Failure, GetTrashResponse>> getTrash() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_TRASH_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data Tidak masuk'));
    }
  }

  Future<Either<Failure, GetTrashResponse>> getTrashSuper() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_TRASH_SUPER_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      print(response);
      return Right(GetTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data Tidak masuk'));
    }
  }

  Future<Either<Failure, PostTrashResponse>> postTrashSuper(
      PriceTrashRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().post(
        NetworkConstants.POST_SUPER_TRASH_URL,
        data: {
          "name": data.name,
          "weight": data.weight,
          "price": data.price,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(PostTrashResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data Tidak masuk'));
    }
  }

  Future<Either<Failure, PostTrashResponse>> editTrashSuper(
      PriceTrashRequest data, String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().put(
        NetworkConstants.EDIT_PRICE_TRASH_URL(id),
        data: {
          "name": data.name,
          "weight": data.weight,
          "price": data.price,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(PostTrashResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data Tidak masuk'));
    }
  }

  Future<Either<Failure, DeletePriceTrashResponse>> deletePriceTrash(
      String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().delete(
        NetworkConstants.DELETE_PRICE_TRASH_URL(id),
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(DeletePriceTrashResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'Nor data Tidak masuk'));
    }
  }
}
