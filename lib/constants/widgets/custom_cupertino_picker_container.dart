import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';

class CupertinoPickerContainer extends StatelessWidget {
  final Widget child;
  final double? containerHeight;
  final double? listHeight;
  final Color? color;
  const CupertinoPickerContainer(
      {required this.child,
      this.containerHeight,
      this.listHeight,
      this.color = AppColors.primaryColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contextHeight = MediaQuery.of(context).size.height;
    return Container(
      height: containerHeight ?? contextHeight * 0.5,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Done',
                  style: TextStyle(
                      color: color,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w800,
                      fontSize: SizeConfig.textMultiplier! * 2))),
          SizedBox(height: listHeight ?? contextHeight * 0.43, child: child),
        ],
      ),
    );
  }
}
