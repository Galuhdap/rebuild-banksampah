import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/config/theme_config.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController _controller;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool isObscure;
  final bool suffixIcon;
  final Color fillColor;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextStyle? hintStyle;
  final Color enabledBorderColor;
  final double? enabledBorderWidth;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {Key? key,
      required TextEditingController controller,
      this.label,
      this.hintText,
      required this.keyboardType,
      this.prefixIcon,
      this.validator,
      this.isObscure = false,
      this.suffixIcon = false,
      this.autovalidateMode,
      this.onTap,
      this.fillColor = Colors.white,
      this.hintStyle,
      this.enabledBorderColor = AppColors.colorSecondary400,
      this.enabledBorderWidth,
      this.onChanged,
      this.inputFormatters,
      this.readOnly = false})
      : _controller = controller,
        super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscurePwd = false;

  @override
  void initState() {
    setState(() {
      isObscurePwd = widget.isObscure;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: widget._controller,
      onTap: widget.onTap,
      validator: widget.validator,
      obscureText: isObscurePwd,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        //label: Text(label),
        hintStyle: widget.hintStyle ?? Get.textTheme.bodyMedium,
        prefixIcon: widget.prefixIcon,
        suffixIcon: !widget.suffixIcon
            ? null
            : IconButton(
                icon: Icon(
                  isObscurePwd ? Icons.visibility : Icons.visibility_off,
                  color: isObscurePwd
                      ? ThemeConfig.neutral70
                      : ThemeConfig.neutral50,
                ),
                onPressed: () {
                  setState(() {
                    isObscurePwd = !isObscurePwd;
                  });
                },
              ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s10),
          borderSide: BorderSide(
              color: AppColors.colorSecondary400, width: AppSizes.s2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.enabledBorderColor,
              width: widget.enabledBorderWidth ?? AppSizes.s1),
          borderRadius: BorderRadius.circular(AppSizes.s10),
        ),
        contentPadding: AppSizes.symmetricPadding(
            horizontal: AppSizes.s20, vertical: AppSizes.s20),
      ),
      cursorColor: AppColors.colorBaseBlack,
      style: TextStyle(
        fontSize: AppSizes.s16,
        color: Colors.black,
      ),
    );
  }
}
