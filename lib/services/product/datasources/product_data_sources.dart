import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/product/model/request/product_request.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/post_product_response.dart';

class ProductDataSources extends ApiService {
  Future<Either<Failure, GetProductResponse>> getProduct() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_PRODUCT_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetProductResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data masuk'));
    }
  }

  Future<Either<Failure, PostProductResponse>> postProduct(
      ProductRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    final formData = FormData.fromMap({
      'name': data.name,
      'price': data.price,
      'stock': data.stock,
      'image': await MultipartFile.fromFile(data.image!.path),
    });

    try {
      final response = await Dio().post(
        NetworkConstants.POST_PRODUCT_URL,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(PostProductResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data masuk'));
    }
  }

  Future<Either<Failure, PostProductResponse>> putProduct(
      ProductRequest data, String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    final formData = FormData.fromMap({
      'name': data.name,
      'price': data.price,
      'stock': data.stock,
      'image': data.image == null
          ? null
          : await MultipartFile.fromFile(data.image!.path),
    });
    // final formData = FormData.fromMap({
    //   'name': name,
    //   'price': price,
    //   'stock': stock,
    //   'image': file == null ? null : await MultipartFile.fromFile(file.path),
    // });

    try {
      final response = await Dio().put(
        NetworkConstants.PUT_PRODUCT_URL(id),
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );

      return Right(PostProductResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data masuk'));
    }
  }

  //   Future<Either<Failure, DeleteDepositTrashResponse>> deleteProduct(
  //     String id) async {
  //   final prefs = await SharedPreferencesUtils.getAuthToken();

  //   try {
  //     final response = await Dio().delete(
  //       NetworkConstants.DELETE_PRODUCT_URL(id),
  //       options: Options(
  //         headers: {
  //           "Authorization": "Bearer ${prefs}",
  //         },
  //       ),
  //     );

  //     return Right(DeleteDepositTrashResponse.fromJson(response.data));
  //   } catch (e) {
  //     return Left(Failure(400, 'Nor data Tidak masuk'));
  //   }
  // }
}
