import 'package:flutter/material.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';

class ProfileWidget extends StatelessWidget {
  final ImageProvider<Object>? backgroundImage;
  final VoidCallback onTap;
  const ProfileWidget({
    super.key,
    required this.backgroundImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: AppSizes.s60,
            backgroundColor: Colors.red,
            backgroundImage: backgroundImage,
          ),
          Positioned(
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