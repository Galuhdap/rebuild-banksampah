import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/product/model/request/post_product_buy_request.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product_buy_customer_response.dart';

class ProductCustomerDataSources extends ApiService {
  Future<Either<Failure, GetProductResponse>> getProductCustomer() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_PRODUCT_CUSTOMER_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetProductResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data masuk'));
    }
  }

  Future<Either<Failure, GetProductBuyCustomerResponse>> postBuyProductCutomer(
      PostProductBuyRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await Dio().post(
        NetworkConstants.POST_PRODUCT_BUY_CUSTOMER_URL,
        data: {
          'userId': data.userId,
          'products': data.listProductData,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs}",
          },
        ),
      );
      return Right(GetProductBuyCustomerResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(400, 'No data masuk'));
    }
  }
}
