import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/input_component.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';


class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool isObscure;
  final bool suffixIcon;
  const InputWidget(
      {super.key,
      required this.controller,
      required this.label,
      required this.hintText,
      required this.textInputType,
      required this.validator,
       this.isObscure = false,
      this.suffixIcon = false,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.labelLarge,
        ),
        AppSizes.s10.height,
        CustomTextField(
          hintText: hintText,
          controller: controller,
          keyboardType: textInputType,
          validator: validator,
          isObscure: isObscure,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}