import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/customer_deposit_trash_datasources.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/customer/get_deposit_customer_trash_response.dart';

class CustomerTrashRepository {
  final CustomerDepositTrashDatasources sources;

  CustomerTrashRepository(this.sources);

  Future<Either<Failure, GetCustomerDepositTrashResponse>>
      getCustomerDeposit() async {
    return sources.getCustomerDeposit();
  }
}
