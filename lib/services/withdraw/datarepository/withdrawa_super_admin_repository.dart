import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/withdraw/datasources/withdraw_super_admin_datasources.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/status_withdraw_super_admin.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/post_withdraw_status_admin_koprasi.dart';

class WithdrawaSuperAdminRepository {
  final WithdrawSuperAdminDatasources sources;

  WithdrawaSuperAdminRepository(this.sources);

  Future<Either<Failure, GetWithdarawAdminKoprasiResponse>>
      getWithdarawSuperadmin() async {
    return sources.getWithdarawSuperAdmin();
  }

  Future<Either<Failure, PostWithdrawResponse>> postWithdrawStatusAdmin(
      PostUpdateStatusWithdrawRequest data) async {
    return sources.postWithdrawStatusAdmin(data);
  }
}
