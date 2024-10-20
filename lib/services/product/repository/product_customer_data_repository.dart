import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/product/datasources/product_customer_data_sources.dart';
import 'package:rebuild_bank_sampah/services/product/model/request/post_product_buy_request.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product_buy_customer_response.dart';

class ProductCustomerDataRepository {
  final ProductCustomerDataSources sources;

  ProductCustomerDataRepository(this.sources);

  Future<Either<Failure, GetProductResponse>> getProductCustomer() async {
    return sources.getProductCustomer();
  }

  Future<Either<Failure, GetProductBuyCustomerResponse>> postBuyProductCustomer(PostProductBuyRequest data) async {
    return sources.postBuyProductCutomer(data);
  }
}
