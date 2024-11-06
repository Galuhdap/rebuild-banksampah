import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/report/controller/report_controller.dart';
import 'package:rebuild_bank_sampah/presentation/report/screen/pdf/pdf_priview.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<ChartData> chartData = [
    //   ChartData('David', 25),
    //   ChartData('Steve', 38),
    //   ChartData('Jack', 34),
    //   ChartData('Others', 52)
    // ];
    return GetBuilder<ReportController>(
      init: ReportController(),
      builder: (controller) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.LABEL_TYPE_TRASH,
                            style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s12,
                            ),
                          ),
                          AppSizes.s10.height,
                          DropDownSearchFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              decoration: InputDecoration(
                                hintText: 'Pilih Jenis Sampah',
                                suffixIcon: Icon(Iconsax.arrow_down_1),
                                hintStyle: Get.textTheme.titleMedium!.copyWith(
                                    color: AppColors.colorSecondary600,
                                    fontSize: AppSizes.s15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.s10),
                                  borderSide: BorderSide(
                                    color: AppColors.colorSecondary400,
                                    width: AppSizes.s1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.s10),
                                  borderSide: BorderSide(
                                      color: AppColors.colorSecondary400,
                                      width: AppSizes.s2),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: AppSizes.s16,
                                color: Colors.black,
                              ),
                              controller: controller.dropdownTrashController,
                            ),
                            suggestionsCallback: (pattern) {
                              return controller.getTrashSuggestions(pattern);
                            },
                            itemBuilder: (context, GroupTrash suggestion) {
                              return ListTile(
                                title: Text(
                                  suggestion.nama,
                                  style: TextStyle(
                                    fontSize: AppSizes.s16,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                            itemSeparatorBuilder: (context, index) {
                              return const Divider();
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (GroupTrash suggestion) {
                              controller.dropdownTrashController.text =
                                  suggestion.nama;
                              controller.selectedTrashId.value = suggestion.id;
                              controller.chartDatas.clear();
                              controller.getReportDeposit();
                            },
                            suggestionsBoxController:
                                controller.suggestionBoxController,
                            validator: (value) => value!.isEmpty
                                ? 'Please select a Jenis Sampah'
                                : null,
                            onSaved: (value) {},
                            displayAllSuggestionWhenTap: true,
                          ),
                          // Obx(() => Text(
                          //     'ID Jenis Sampah yang dipilih: ${controller.selectedTrashId.value}')),
                        ],
                      ),
                    ),
                    AppSizes.s20.width,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pilih Bulan',
                            style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s12,
                            ),
                          ),
                          AppSizes.s6.height,
                          TextFormField(
                            controller: controller.textController,
                            keyboardType: TextInputType.name,
                            readOnly: true,
                            decoration: InputDecoration(
                              //filled: true,
                              hintText: controller.yearMonth.isNotEmpty
                                  ? controller.yearMonth.value
                                  : 'Pilih Bulan',
                              //fillColor: AppColors.colorNeutrals0,
                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                fontSize: AppSizes.s14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.colorNeutrals300,
                              ),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  final selectedDates = await showMonthPicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2050),
                                  );

                                  if (selectedDates != null) {
                                    String formattedMonth =
                                        DateFormat('yyyy-MM')
                                            .format(selectedDates);
                                    controller.selectedDate.value =
                                        selectedDates;
                                    controller.yearMonth.value = formattedMonth;
                                    controller.getReportDeposit();
                                  }
                                },
                                child: Icon(
                                  Iconsax.calendar_2,
                                  color: AppColors.colorNeutrals300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s10),
                                borderSide: BorderSide(
                                    color: AppColors.colorNeutrals300,
                                    width: AppSizes.s2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorNeutrals300,
                                    width: AppSizes.s1),
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s10),
                              ),
                              contentPadding: AppSizes.symmetricPadding(
                                  horizontal: AppSizes.s13,
                                  vertical: AppSizes.s20),
                            ),
                            // cursorColor: AppColors.colorNeutrals500,
                            style: Get.textTheme.labelMedium!.copyWith(
                              fontSize: AppSizes.s14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorNeutrals500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                    vertical: AppSizes.s18, horizontal: AppSizes.s24),
                Button.outlined(
                  onPressed: () {
                    controller.yearMonth.value = '';
                    controller.selectedTrashId.value = '';
                    controller.dropdownTrashController.clear();
                    controller.getReportDeposit();
                  },
                  label: 'Reset Filter',
                ).paddingSymmetric(horizontal: AppSizes.s24),
                Obx(() => controller.chartDatas.isNotEmpty
                    ? Center(
                        child: Container(
                          child: SfCircularChart(
                            series: <CircularSeries>[
                              // Render pie chart
                              PieSeries<ChartData, String>(
                                dataSource: controller.chartDatas,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, _) =>
                                    data.x, // Menggunakan nama sebagai label x
                                yValueMapper: (ChartData data, _) =>
                                    data.y, // Menggunakan nilai sebagai label y
                                dataLabelMapper: (ChartData data, _) =>
                                    '${data.x}: \n${data.y}', // Menampilkan nama dan nilai
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true, // Menampilkan label
                                  labelPosition: ChartDataLabelPosition
                                      .outside, // Posisi label di luar pie
                                  connectorLineSettings: ConnectorLineSettings(
                                    length: '5%', // Panjang garis penghubung
                                    width: 1, // Ketebalan garis penghubung
                                  ),
                                  textStyle: TextStyle(
                                    color: Colors.black, // Warna teks label
                                    fontSize: 12, // Ukuran font label
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Lottie.asset(Assets.lottie.loadingUniversal),
                        ),
                      )),
                Center(
                  child: Button.filled(
                      onPressed: () {
                        Get.to(PdfPriview(
                          date: controller.selectedDate.toString(),
                        ));
                      },
                      label: 'Cetak PDF'),
                ).paddingSymmetric(horizontal: AppSizes.s90),
              ],
            ),
          ),
        );
      },
    );
  }
}
