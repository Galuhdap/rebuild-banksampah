import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/report/controller/get_commodity_daily_response.dart';
import 'package:rebuild_bank_sampah/services/report/model/request/get_data_report_trash_request.dart';
import 'package:rebuild_bank_sampah/services/report/model/response/get_data_report_trash_response.dart';
import 'package:rebuild_bank_sampah/services/report/report_repository.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/trash_respository.dart';

class ReportController extends GetxController {
  final TrashRepository trashRepository = locator();
  final ReportRepository reportRepository = locator();

  RxInt selectedX = 0.obs;
  RxDouble selectedY = 0.0.obs;
  Rx<DateTime> selectedTime = DateTime.now().obs;
  RxList<GroupTrash> listTrash = <GroupTrash>[].obs;
  RxList<DataReportTrash> listReportTrash = <DataReportTrash>[].obs;
  RxBool isloadingTrash = false.obs;
  RxBool isloadingReportTrash = false.obs;
  RxString selectedTrashId = ''.obs;
  RxString yearMonth = ''.obs;
  Rx<DateTime?> selectedDate = DateTime.now().obs;

  RxList<ChartData> chartDatas = <ChartData>[].obs;

  final TextEditingController dropdownTrashController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  //RxList<ChartDataModel> chartDatas = <ChartDataModel>[].obs;
  RxList<DataDaily> listCommodityGrafilDaily = <DataDaily>[].obs;

  List<GroupTrash> getTrashSuggestions(String query) {
    return listTrash
        .where(
            (trash) => trash.nama.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    getTrash();
    getReportDeposit();
  }

  // final List<ChartData> chartData = [
  //   ChartData('David', 25),
  //   ChartData('Steve', 38),
  //   ChartData('Jack', 34),
  //   ChartData('Others', 52)
  // ];

  Future<void> getTrash() async {
    isloadingTrash.value = true;
    try {
      final response = await trashRepository.getTrashSuper();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listTrash.addAll(response.data);
        },
      );
      isloadingTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingTrash.value = false;
    }
  }

  Future<void> getReportDeposit() async {
    isloadingReportTrash.value = true;
    listReportTrash.clear();
    chartDatas.clear();
    try {
      final data = GetChartRequest(
        yearMonth: yearMonth.value,
        trashId: selectedTrashId.value,
      );

      final response = await reportRepository.getDataReportTrash(data);

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listReportTrash.addAll(response.data);
          chartDatas.value = getChartDataFromReport(listReportTrash);
          update();
        },
      );
      isloadingReportTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingReportTrash.value = false;
    }
  }

  List<ChartData> getChartDataFromReport(
      List<DataReportTrash> listReportTrash) {
    return listReportTrash
        .map((report) => ChartData(report.trashName, report.totalWeight))
        .toList();
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final num y;
  final Color? color;
}
