import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';

class CustomSelectBottomSheet extends StatelessWidget {
  final String hint;
  final Function()? onPressed;
  final String value;
  final double? width;
  final Color? color;

  const CustomSelectBottomSheet({
    Key? key,
    required this.hint,
    required this.onPressed,
    required this.value,
    this.width,
    this.color = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.shortestSide > 600
            ? SizeConfig.heightMultiplier! * 5
            : SizeConfig.heightMultiplier! * 7,
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          color: Colors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.widthMultiplier! * 4,
                right: SizeConfig.widthMultiplier! * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != '' ? value : hint,
                  style: value == ''
                      ? AppFonts.inputLabelStyle
                      : TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: SizeConfig.textMultiplier! * 2,
                          fontWeight: FontWeight.w400,
                        ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: color,
                  size: SizeConfig.imageSizeMultiplier! * 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
