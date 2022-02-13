import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_fonts.dart';

class CustomPinBoxes extends StatelessWidget {
  const CustomPinBoxes({
    Key? key,
    required this.onSaved,
    this.enabled = true,
  }) : super(key: key);

  final Function(String?)? onSaved;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final securedPin = Container(
      height: 15,
      width: 15,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
    return PinCodeTextField(
      enabled: enabled,
      //autoFocus: true,
      keyboardType: TextInputType.number,
      obscuringWidget: securedPin,
      length: 6,
      onChanged: (value) {
        // print(value);
      },
      appContext: context,
      onSaved: onSaved,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderWidth: 2,
        borderRadius: BorderRadius.circular(8.0),
        fieldHeight: MediaQuery.of(context).size.shortestSide > 600
            ? SizeConfig.heightMultiplier! * 6
            : SizeConfig.heightMultiplier! * 8,
        fieldWidth: SizeConfig.widthMultiplier! * 11,
        inactiveFillColor: Colors.black12,
        activeFillColor: Colors.black12,
        selectedFillColor: Colors.black12,
        inactiveColor: Colors.black12,
        activeColor: Colors.black12,
        selectedColor: Colors.black,
      ),
      textStyle: AppFonts.heading2,
    );
  }
}
