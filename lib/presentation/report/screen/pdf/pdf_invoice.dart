// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:pdf/widgets.dart' as pw;

// class PdfInvoiceApi {
//   Future<Uint8List> generate() async {
//     final pdf = Document();
//     final ByteData bytes = await rootBundle.load('assets/images/logo_adb.png');
//     final Uint8List imageData = bytes.buffer.asUint8List();

//     // Create image object
//     final image = pw.MemoryImage(imageData);

//     pdf.addPage(
//       MultiPage(
//         pageFormat: PdfPageFormat.legal,
//         build: (context) => [
//           //buildHeader(image),
//           // buildTitle(),
//           SizedBox(height: 5),
//           buildTabelPenggunaAdmin(),
//           //buildTable(),
//           SizedBox(height: 10),
//           // daclaresTable(),
//           // SizedBox(height: 10),
//           // boadTable(),
//           // SizedBox(height: 40),
//           // signature()
//         ],
//         //footer: (context) => buildFooter(),
//       ),
//     );

//     return pdf.save();
//   }

//   static Widget buildTabelPenggunaAdmin(
//       //LaporanAdmin invoice
//       ) {
//     final headers = [
//       'Tanggal',
//       'Kode BS',
//       'Nama BS',
//       'No Telp',
//       'Berat',
//       'Saldo',
//     ];
//     // final data = invoice.itemsAdmin.map((item) {
//     //   return [
//     //     DateFormat(' dd MMMM yyyy', 'id_ID')
//     //         .format(DateTime.parse(item.createdAt.toString())),
//     //     item.kodeAdmin,
//     //     item.namaBs,
//     //     '${item.noTelp}',
//     //     item.berat,
//     //     CurrencyFormat.convertToIdr(item.saldo, 0),
//     //     //   item.detailSampahBs![0].saldo,
//     //   ];
//     // }).toList();

//     return Table.fromTextArray(
//       headers: headers,
//       data: [
//         // DateFormat(' dd MMMM yyyy', 'id_ID')
//         //     .format(DateTime.parse(item.createdAt.toString())),
//         // 'asdds',
//         // item.namaBs,
//         // '${item.noTelp}',
//         // item.berat,
//         // CurrencyFormat.convertToIdr(item.saldo, 0),
//         //   item.detailSampahBs![0].saldo,
//       ],
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//         5: Alignment.centerRight,
//         6: Alignment.centerRight,
//         7: Alignment.centerRight,
//         8: Alignment.centerRight,
//       },
//     );
//   }
// }
