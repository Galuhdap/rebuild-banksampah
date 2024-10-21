import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/customer_deposit_trash_datasources.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/customer/get_deposit_trash_update_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';

class CustomerTrashRepository {
  final CustomerDepositTrashDatasources sources;

  CustomerTrashRepository(this.sources);

  Future<Either<Failure, DepositTrashResponse>> getCustomerDeposit() async {
    return sources.getCustomerDeposit();
  }

  Future<Either<Failure, GetDepositTrashUpdateResponse>> getDepositStatus(
      PostUpdateStatusRequest data) async {
    return sources.postDepositStatusCustomer(data);
  }
}
