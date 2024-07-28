
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/presentation/home/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          body: controller.role.value != "CUSTOMER" ? 
          Center(
            child: Text('Ini CUSTOMER'),
          ) : Center(
            child: Text('Ini Testing'),
          ) 
        );
      },
    );
  }
}
