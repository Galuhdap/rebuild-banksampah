import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/report/model/request/get_data_report_trash_request.dart';
import 'package:rebuild_bank_sampah/services/report/model/response/get_data_report_trash_response.dart';

class ReportDataSource extends ApiService {
  var token;

  Future<Either<Failure, GetDataReportTrashResponse>> getDataReportTrash(
      GetChartRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_REPORT_TRASH_URL(data), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetDataReportTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'Data tidak masuk'));
    }
  }
}
