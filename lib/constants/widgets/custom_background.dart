import 'package:flutter/material.dart';
import 'package:sportconnect/constants/app_images.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(AppImages.background),
          fit: BoxFit.fitWidth,
        ),
      ),
      padding: EdgeInsets.only(top: height * 0.01),
      child: child,
    );
  }
}
