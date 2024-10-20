import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/product/datasources/product_data_sources.dart';
import 'package:rebuild_bank_sampah/services/product/model/request/product_request.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/post_product_response.dart';

class ProductDataRepository {
  final ProductDataSources sources;

  ProductDataRepository(this.sources);

  Future<Either<Failure, GetProductResponse>> getProduct() async {
    return sources.getProduct();
  }

  Future<Either<Failure, PostProductResponse>> postProduct(
      ProductRequest data) async {
    return sources.postProduct(data);
  }
}
