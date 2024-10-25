import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/customer_deposit_trash_datasources.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/post_deposit_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/customer/get_deposit_trash_update_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/post_deposit_trash_response.dart';

class CustomerTrashRepository {
  final CustomerDepositTrashDatasources sources;

  CustomerTrashRepository(this.sources);

  Future<Either<Failure, DepositTrashResponse>> getCustomerDeposit() async {
    return sources.getCustomerDeposit();
  }

  Future<Either<Failure, DepositTrashResponse>> getSuperAdminDeposit() async {
    return sources.getSuperAdminDeposit();
  }

  Future<Either<Failure, GetDepositTrashUpdateResponse>> getDepositStatus(
      PostUpdateStatusRequest data) async {
    return sources.postDepositStatusCustomer(data);
  }

    Future<Either<Failure, PostDepositTrashResponse>> putDepositTrash(
      PostDepositTrashRequest data, String idSummary) async {
    return sources.putDepositTrash(data, idSummary);
  }
}
