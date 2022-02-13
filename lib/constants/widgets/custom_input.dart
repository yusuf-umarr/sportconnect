import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';

import '../app_fonts.dart';
import '../app_input.dart';

class CustomInput extends StatelessWidget {
  final String? hint;
  final String? label;
  final String? description;
  final String? type;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool obsecure;
  final bool enabled;
  final void Function(String?)? onSaved;
  final dynamic validator;
  final int maxLines;

  const CustomInput({
    Key? key,
    this.hint,
    this.label,
    this.initialValue = '',
    this.description,
    this.obsecure = false,
    required this.onSaved,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.type,
    this.width,
    this.enabled = true,
    this.maxLines = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            child: TextFormField(
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: SizeConfig.textMultiplier! * 2,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: AppColors.primaryColor,
              obscureText: obsecure,
              enabled: enabled,
              // inputFormatters: [
              //   if (label == "Amount" || label == "Target Amount")
              //     ThousandsFormatter(),
              // ],
              keyboardType: type == 'number'
                  ? const TextInputType.numberWithOptions(
                      signed: true, decimal: true)
                  : TextInputType.text,
              maxLength: type == 'number' ? 11 : 255,
              maxLines: maxLines,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    left: SizeConfig.widthMultiplier! * 4,
                    right: SizeConfig.widthMultiplier! * 2),
                errorMaxLines: 1,
                hintText: hint,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintStyle: const TextStyle(
                    color: Colors.black26, fontFamily: 'Outfit', fontSize: 12),
                errorBorder: AppInput.errorBorder,
                errorStyle: AppInput.errorStyle,
                counterText: '',
                labelText: label,
                labelStyle: AppFonts.inputLabelStyle,
                focusedErrorBorder: AppInput.errorBorder,
                filled: true,
                fillColor: enabled == true
                    ? const Color(0xFFE5E5E5).withOpacity(0.3)
                    : const Color(0xFFE5E5E5).withOpacity(0.6),
                focusedBorder: AppInput.focusedBorder,
                border: AppInput.border,
              ),
              initialValue: initialValue,
              validator: validator,
              onSaved: onSaved,
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                description!,
                style: AppFonts.body3,
              ),
            ),
        ],
      ),
    );
  }
}
