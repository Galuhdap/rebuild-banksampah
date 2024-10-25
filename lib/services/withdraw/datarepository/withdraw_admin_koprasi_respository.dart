import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/withdraw/datasources/withdraw_admin_koprasi_datasources.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/status_withdraw_super_admin.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/withdraw_admin_koprasi_request.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/post_withdraw_admin_koprasi_response.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/post_withdraw_status_admin_koprasi.dart';

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

  Future<Either<Failure, PostWithdrawResponse>> postWithdrawStatusAdminKoprasi(
      PostUpdateStatusWithdrawRequest data) async {
    return sources.postWithdrawStatusAdminKoprasi(data);
  }
}
