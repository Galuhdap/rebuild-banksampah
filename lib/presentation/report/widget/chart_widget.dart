// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:rebuild_bank_sampah/core/config/theme_config.dart';
// import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
// import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
// import 'package:rebuild_bank_sampah/presentation/report/controller/report_controller.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class ChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ReportController controller = Get.put(ReportController());
//     return SfCartesianChart(
//       plotAreaBorderWidth: AppSizes.s0,
//       primaryXAxis: DateTimeAxis(
//         dateFormat: DateFormat.d(),
//         intervalType: DateTimeIntervalType.days,
//         majorGridLines:
//             MajorGridLines(width: AppSizes.s1, color: ThemeConfig.neutral40),
//         axisLine: AxisLine(color: Colors.transparent),
//         labelStyle: Get.textTheme.labelMedium,
//         rangePadding: ChartRangePadding.additional,
//         interval: AppSizes.s1,
//         majorTickLines: MajorTickLines(width: AppSizes.s0, size: 10),
//       ),
//       primaryYAxis: NumericAxis(
//         majorGridLines: MajorGridLines(width: AppSizes.s0),
//         axisLine: AxisLine(width: AppSizes.s0, color: Colors.transparent),
//         isVisible: false,
//         majorTickLines: MajorTickLines(width: AppSizes.s0, size: 5),
//       ),
//       series: <CartesianSeries>[
//         AreaSeries<ChartDataModel, DateTime>(
//           // dataSource: controller.chartDatas,
//           dataSource: controller.chartDatas,
//           xValueMapper: (ChartDataModel data, _) => data.time,
//           yValueMapper: (ChartDataModel data, _) => data.y,
//           gradient: LinearGradient(
//             colors: [
//               AppColors.colorBasePrimary.withOpacity(0.3),
//               AppColors.colorBasePrimary.withOpacity(0.0),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderColor: AppColors.colorBasePrimary,
//           borderWidth: 1.5,
//           markerSettings: MarkerSettings(
//             isVisible: true,
//             color: AppColors.colorBasePrimary,
//           ),
//           onPointTap: (ChartPointDetails details) {
//             //controller.updateAnnotation(details.pointIndex!);
//           },
//         ),
//       ],
//       annotations: <CartesianChartAnnotation>[
//         CartesianChartAnnotation(
//           widget: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height: AppSizes.s50,
//                 width: AppSizes.s2,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.colorBasePrimary,
//                       AppColors.colorBasePrimary,
//                       AppColors.colorBasePrimary.withOpacity(0.0),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//               Container(
//                 width: AppSizes.s23,
//                 height: AppSizes.s23,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(AppSizes.s360),
//                   border: Border.all(
//                       color: AppColors.colorBasePrimary, width: AppSizes.s2),
//                 ),
//               ),
//             ],
//           ),
//           coordinateUnit: CoordinateUnit.point,
//           x: controller.selectedTime.value,
//           y: controller.selectedY.value,
//         ),
//       ],
//     ).paddingOnly(top: AppSizes.s5);
//   }
// }


