import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/presentation/splash/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            children: [
              Center(
                child: Assets.images.logobs.image(scale: 3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Assets.images.logoBlitar.image(scale: 4),
                  Assets.images.logoUntag.image(scale: 4),
                  Assets.images.logoTuturi.image(scale: 4),
                ],
              ).paddingSymmetric(horizontal: AppSizes.s100),
            ],
          ),
          Text(
            'Hibah Pemberdayaan Desa Binaan DRTPM 2024',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Get.textTheme.titleMedium!.copyWith(fontSize: 15),
          ),
        ],
      ).paddingSymmetric(vertical: AppSizes.s60)
    );
  }
}
