import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/withdraw/datasources/withdraw_admin_koprasi_datasources.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/withdraw_admin_koprasi_request.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/post_withdraw_admin_koprasi_response.dart';

class WithdrawAdminKoprasiRespository {
  final WithdrawAdminKoprasiDatasources sources;

  WithdrawAdminKoprasiRespository(this.sources);

  Future<Either<Failure, GetWithdarawAdminKoprasiResponse>>
      getWithdarawAdminKoprasi() async {
    return sources.getWithdarawAdminKoprasi();
  }

  Future<Either<Failure, PostWithdarawAdminKoprasiResponse>>
      postWithdrawAdminKoprasi(WithdrawAdminKoprasiRequest data) async {
    return sources.postWithdrawAdminKoprasi(data);
  }
}
