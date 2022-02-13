import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final Function() onpressed;
  final double? width;
  final Color? color;
  final double? height;
  final Color? textColor;
  final double? radius;

  const CustomOutlineButton({
    Key? key,
    required this.text,
    required this.onpressed,
    this.width,
    this.height,
    this.textColor,
    this.radius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeConfig.heightMultiplier! * 7,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
          border: Border.all(
              color: color != null ? color! : AppColors.primaryColor)),
      child: MaterialButton(
        elevation: 0,
        minWidth: width ?? MediaQuery.of(context).size.width * 0.9,
        splashColor: AppColors.primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier! * 2,
            fontFamily: 'Outfit',
            color: color != null ? color! : AppColors.primaryColor,
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
