import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/order/datasources/order_admin_data_sources.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_admin_response.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_admin_status_response.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_customer_response.dart';

class OrderAdminDataRepository {
  final OrderAdminDataSources sources;

  OrderAdminDataRepository(this.sources);

  Future<Either<Failure, GetOrderAdminResponse>> getOrder() async {
    return sources.getOrder();
  }
  Future<Either<Failure, GetOrderCustomerResponse>> getOrderCustomer() async {
    return sources.getOrderCustomer();
  }

  Future<Either<Failure, GetOrderAdminStatusResponse>> postOrderStatusAdmin(
      PostUpdateStatusRequest data) async {
    return sources.postOrderStatusAdmin(data);
  }
}
