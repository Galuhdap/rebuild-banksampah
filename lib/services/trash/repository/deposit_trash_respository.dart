import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/deposit_trash_data_sources.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/deposit_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/delete_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_customer_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/post_deposit_trash_response.dart';

class DepositTrashDataRespository {
  final DepositTrashDataSources sources;

  DepositTrashDataRespository(this.sources);

  Future<Either<Failure, DepositTrashResponse>> getDepositTrash() async {
    return sources.getDepositTrash();
  }

  Future<Either<Failure, CustomerDepositTrashResponse>>
      getCustomerDepositTrash() async {
    return sources.getCustomerDepositTrash();
  }

  Future<Either<Failure, PostDepositTrashResponse>> postDepositTrash(
      DepositTrashRequest data) async {
    return sources.postDepositTrash(data);
  }

  Future<Either<Failure, DeleteDepositTrashResponse>> deleteDepositTrash(
      String id) async {
    return sources.deleteDepositTrash(id);
  }
}
