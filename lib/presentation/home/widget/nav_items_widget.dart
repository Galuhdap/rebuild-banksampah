import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';

class NavItems extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  const NavItems(
      {super.key,
      required this.label,
      required this.iconPath,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(1.0)),
        child: Container(
          width: AppSizes.s120,
          height: AppSizes.s44,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: AppSizes.s20,
                height: AppSizes.s20,
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    isActive ? AppColors.colorBasePrimary : AppColors.colorSecondary500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              AppSizes.s6.width,
              Text(
                label,
                style: TextStyle(
                    fontSize: AppSizes.s12,
                    color: isActive ? AppColors.colorBasePrimary: AppColors.colorSecondary500,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}