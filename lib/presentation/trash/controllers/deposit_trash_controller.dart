import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_dialog.dart';

class DepositTrashController extends GetxController {
  final TextEditingController kode_nasabah = TextEditingController();
  final TextEditingController type_trash  = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController price = TextEditingController();

  final TextEditingController searchDepositTrash = TextEditingController();

  void inputTrashController(InputControllerTrash input){
    
  }

}