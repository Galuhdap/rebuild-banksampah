import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/home/datasources/home_datasources.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_admin_koprasi_balanse_response.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_customer_balance_response.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_weigher_summary_response.dart';

class HomeRepository {
  final HomeDatasources sources;

  HomeRepository(this.sources);

  Future<Either<Failure, GetCustomerBalanceResponse>>
      getBalanceCustomer() async {
    return sources.getBalanceCustomer();
  }

  Future<Either<Failure, GetWeigherSummaryResponse>> getSummaryWeigher() async {
    return sources.getSummaryWeigher();
  }

  Future<Either<Failure, GetBalanceAdminKoprasiResponse>> getSummaryAdminKoprasi() async {
    return sources.getSummaryAdminKoprasi();
  }
}
