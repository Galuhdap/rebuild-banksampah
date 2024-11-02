import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/presentation/report/controller/get_commodity_daily_response.dart';

class ReportController extends GetxController {
  RxInt selectedX = 0.obs;
  RxDouble selectedY = 0.0.obs;
  Rx<DateTime> selectedTime = DateTime.now().obs;
  // List<ChartDataModel>? chartDatas = [
  //   ChartDataModel(x: 0, y: 1),
  //   ChartDataModel(x: 1, y: 2),
  //   ChartDataModel(x: 2, y: 3),
  //   ChartDataModel(x: 3, y: 4),
  //   ChartDataModel(x: 4, y: 5)
  // ];
  RxList<ChartDataModel> chartDatas = <ChartDataModel>[].obs;
  RxList<DataDaily> listCommodityGrafilDaily = <DataDaily>[].obs;

  // List<ChartDataModel> chartData(List<DataDaily> listCommodityGrafilDaily) {
  //   return List<ChartDataModel>.generate(listCommodityGrafilDaily.length,
  //       (index) {
  //     bool isDailyDataAvailable = listCommodityGrafilDaily.isNotEmpty &&
  //         index < listCommodityGrafilDaily.length;
  //     return ChartDataModel(
  //       x: index,
  //       y: isDailyDataAvailable
  //           ? listCommodityGrafilDaily[index].value.toDouble()
  //           : 0.0,
  //       // time: isDailyDataAvailable
  //       //     ? listCommodityGrafilDaily[index].time
  //       //     : DateTime.now().subtract(Duration(days: 7)),
  //     );
  //   });
  // }

  Future<void> updateSelected() async {
    if (listCommodityGrafilDaily.isNotEmpty) {
      selectedX.value = listCommodityGrafilDaily[0].time.day;
      selectedY.value = listCommodityGrafilDaily[0].value.toDouble();
      selectedTime.value = listCommodityGrafilDaily[0].time;
    } else {
      selectedTime.value = listCommodityGrafilDaily[0].time;
    }
  }

  void generateDummyData() {
    final now = DateTime.now();
    chartDatas.value = List.generate(10, (index) {
      return ChartDataModel(
        time: now.subtract(Duration(days: index)),
        y: (index + 1) * 10.0, // nilai y meningkat setiap data
      );
    });
  }

  // void updateAnnotation(int index) {
  //   selectedX.value = chartDatas[index].time.day;
  //   selectedY.value = chartDatas[index].y!;
  //   selectedTime.value = chartDatas[index].time;
  //   update();
  // }
}

class ChartDataModel {
  //required this.time
  ChartDataModel({this.x, this.y, required this.time});
  final int? x;
  final double? y;
  final DateTime time;
}
