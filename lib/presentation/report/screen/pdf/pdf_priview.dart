import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:printing/printing.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/presentation/report/controller/report_controller.dart';
import 'package:rebuild_bank_sampah/presentation/report/screen/pdf/pdf_invoice.dart';

class PdfPriview extends StatelessWidget {
  final String date;
  const PdfPriview({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    ReportController controller = Get.find();
    PdfInvoiceApi pdfInvoiceApi = PdfInvoiceApi();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan PDF',
          style: Get.textTheme.labelMedium!.copyWith(
            fontSize: AppSizes.s20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_left_2,
            color: AppColors.colorNeutrals1000,
          ),
        ),
      ),
      body: PdfPreview(
        build: (context) =>
            pdfInvoiceApi.generate(controller.listReportTrash, date),
        pdfFileName: 'LaporanSampah.${date}.pdf',
      ),
    );
  }
}
