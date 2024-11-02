// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:printing/printing.dart';
// import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
// import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
// import 'package:rebuild_bank_sampah/presentation/report/screen/pdf/pdf_invoice.dart';

// class PdfPriview extends StatelessWidget {
//   const PdfPriview({super.key});

//   @override
//   Widget build(BuildContext context) {
//     PdfInvoiceApi pdfInvoiceApi = PdfInvoiceApi();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Laporan PDF',
//           style: Get.textTheme.labelMedium!.copyWith(
//             fontSize: AppSizes.s20,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Iconsax.arrow_left_2,
//             color: AppColors.colorNeutrals300,
//           ),
//         ),
//       ),
//       body: PdfPreview(
//         build: (context) => pdfInvoiceApi.generate(),
//         pdfFileName: 'struck.pdf',
//       ),
//     );
//   }
// }
