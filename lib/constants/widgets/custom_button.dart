import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';

import '../app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onpressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? radius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onpressed,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeConfig.heightMultiplier! * 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        color: color ?? AppColors.primaryColor,
      ),
      child: MaterialButton(
        elevation: 0,
        minWidth: width ?? MediaQuery.of(context).size.width * 0.9,
        splashColor: AppColors.primaryColor.withOpacity(0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: SizeConfig.textMultiplier! * 2,
            color: textColor ?? Colors.white,
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
