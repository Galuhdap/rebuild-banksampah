import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/report/model/request/get_data_report_trash_request.dart';
import 'package:rebuild_bank_sampah/services/report/model/response/get_data_report_trash_response.dart';
import 'package:rebuild_bank_sampah/services/report/report_data_sources.dart';

class ReportRepository {
  final ReportDataSource source;

  ReportRepository(this.source);

  Future<Either<Failure, GetDataReportTrashResponse>> getDataReportTrash(
      GetChartRequest data) async {
    return source.getDataReportTrash(data);
  }
}
