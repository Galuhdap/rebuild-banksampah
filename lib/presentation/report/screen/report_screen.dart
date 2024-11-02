import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/config/theme_config.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/report/screen/pdf/pdf_priview.dart';
import 'package:rebuild_bank_sampah/presentation/report/widget/chart_widget.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.ACTION_REPORT,
          style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.colorBaseBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   width: AppSizes.setResponsiveWidth(context) * 0.4,
              //   padding: AppSizes.symmetricPadding(vertical: AppSizes.s1),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: ThemeConfig.neutral70,
              //     ),
              //     borderRadius: BorderRadius.circular(AppSizes.s360),
              //   ),
              //   child: DropdownButton(
              //     value: 1,
              //     menuMaxHeight: AppSizes.setResponsiveWidth(context),
              //     underline: SizedBox.shrink(),
              //     icon: Icon(
              //       Icons.keyboard_arrow_down,
              //       weight: AppSizes.s20,
              //       size: AppSizes.s30,
              //       color: ThemeConfig.neutral0,
              //     ),
              //     iconSize: AppSizes.s24,
              //     elevation: 16,
              //     isExpanded: true,
              //     style: ThemeConfig.labelMedium.copyWith(color: Colors.black),
              //     items: controller.listCommodityCity
              //         .map<DropdownMenuItem<int>>((CommodityCity city) {
              //       return DropdownMenuItem<int>(
              //         value: city.cityId,
              //         child: Text(city.name),
              //       );
              //     }).toList(),
              //     onChanged: (Object? value) {
              //       if (value != null && value is int) {
              //         controller.setDropdownValue(value);
              //         controller.getCommodityChartDaily();
              //       }
              //     },
              //   ).paddingSymmetric(horizontal: AppSizes.s25),
              // ),
              // InkWell(
              //   onTap: () async {
              //     List<DateTime?>? selectedDates =
              //         await showCalendarDatePicker2Dialog(
              //       context: context,
              //       config: CalendarDatePicker2WithActionButtonsConfig(
              //         calendarType: CalendarDatePicker2Type.range,
              //         firstDate: DateTime(2000),
              //         lastDate: DateTime.now(),
              //       ),
              //       dialogSize: const Size(325, 400),
              //       value: controller.selectedDate,
              //       borderRadius: BorderRadius.circular(15),
              //     );

              //     if (selectedDates != null) {
              //       bool datesChanged = controller.selectedDate.length !=
              //               selectedDates.length ||
              //           controller.selectedDate.asMap().entries.any(
              //               (entry) => entry.value != selectedDates[entry.key]);
              //       if (datesChanged) {
              //         if (!controller.isRangeWithinLimit(selectedDates)) {
              //         } else {
              //           controller.selectedDate.value = selectedDates;
              //           controller.getCommodityChartDaily();
              //         }
              //       }
              //     }
              //   },
              //   child: Container(
              //       padding: AppSizes.symmetricPadding(
              //           vertical: AppSizes.s5, horizontal: AppSizes.s20),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: ThemeConfig.neutral70,
              //         ),
              //         borderRadius: BorderRadius.circular(AppSizes.s360),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             controller.selectedDate.isNotEmpty &&
              //                     controller.selectedDate[0] != null
              //                 ? '${controller.selectedDate[0]!.toDateddmmFormattedString()} - ${controller.selectedDate[1]!.toDateddmmFormattedString()}'
              //                 : '${DateTime.now().subtract(
              //                       Duration(days: 7),
              //                     ).toDateddmmFormattedString()} - ${DateTime.now().toDateddmmFormattedString()}',
              //             style: ThemeConfig.titleSmall,
              //           ),
              //           AppSizes.s1.width,
              //           Icon(
              //             Icons.keyboard_arrow_down,
              //             weight: AppSizes.s20,
              //             size: AppSizes.s30,
              //             color: ThemeConfig.neutral0,
              //           ),
              //         ],
              //       ).paddingSymmetric(vertical: AppSizes.s5)),
              // ),
            ],
          ).paddingSymmetric(vertical: AppSizes.s24, horizontal: AppSizes.s24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1',
                //Validations.formatSelectedDate(controller),
                style: ThemeConfig.titleSmall,
              ),
              AppSizes.s8.height,
              Text(
                '2',
                //'${controller.chartDatas.isNotEmpty ? controller.selectedY.toInt().currencyFormatRp : 0.currencyFormatRp}/Kg',
                style: ThemeConfig.titleLarge.copyWith(fontSize: AppSizes.s24),
              ),
            ],
          ).paddingSymmetric(horizontal: AppSizes.s24),
          // AppSizes.s20.height,
          // Container(
          //   height: AppSizes.s350,
          //   child: ChartWidget().paddingSymmetric(horizontal: AppSizes.s25),
          // ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                //Get.to(PdfPriview());
              },
              child: Text('Report'),
            ),
          ),
          // Divider(
          //   thickness: 1,
          //   color: ThemeConfig.neutral80,
          // ),
          // AppSizes.s17.height,
          // // Obx(
          //   () => Center(
          //       child: Text(
          //     '${controller.chartDatas.isNotEmpty ? DateFormat('MMMM').format(controller.selectedTime.value) : ''}',
          //     style: Get.textTheme.labelMedium,
          //   )),
          // ),
          20.height,
          // controller.chartDatas.isNotEmpty
          //     ? Row(
          //         children: [
          //           Icon(Icons.info_outline),
          //           5.width,
          //           Text(
          //             AppConstants.LABEL_GRAPH_AVAILABLE_COMMODITIES,
          //             style: Get.textTheme.titleSmall,
          //             maxLines: 3,
          //           )
          //         ],
          //       ).paddingSymmetric(horizontal: AppSizes.s25)
          //     : SizedBox(),
        ]),
      ),
    );
  }
}
