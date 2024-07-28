
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/config/theme_config.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bank Sampah Rebuild',
      initialRoute: AppRoutes.splash,
      theme: ThemeConfig.lightMode,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
    );
  }
}
