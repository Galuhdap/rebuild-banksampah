import 'package:flutter/material.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';

class NoProfileWidget extends StatelessWidget {
  final VoidCallback onTap;
  const NoProfileWidget({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Icon(
            Icons.account_circle,
            color: AppColors.colorPrimary300,
            size: AppSizes.s150,
          ),
          Positioned(
            bottom: AppSizes.s15,
            right: AppSizes.s13,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: AppSizes.allPadding(AppSizes.s4),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.colorBaseWhite,
                        width: AppSizes.s2),
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.colorBasePrimary),
                child: Icon(
                  Icons.create_outlined,
                  color: AppColors.colorBaseWhite,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}