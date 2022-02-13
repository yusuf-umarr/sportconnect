import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/constants/widgets/custom_background.dart';
import 'package:sportconnect/constants/widgets/custom_button.dart';
import 'package:sportconnect/constants/widgets/custom_pin_boxes.dart';
import 'package:sportconnect/constants/widgets/error.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _verifyEmailFormKey = GlobalKey<FormState>();

  String token = '';

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        child: ErrorView(message),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _verifyEmail() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(
          'Its looks like you\'re offline. Please, check your internet connection and try again');
    } else {
      if (!_verifyEmailFormKey.currentState!.validate()) {
        // Invalid !
        return;
      }
      _verifyEmailFormKey.currentState!.save();

      if (token == '') {
        _showErrorDialog('Token is required!');
      } else if (token.length != 6) {
        _showErrorDialog('Token must be 6 digits!');
      } else if (token != '234567') {
        _showErrorDialog('Invalid token!');
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.only(
              left: width * 0.05,
              right: width * 0.05,
              top: SizeConfig.heightMultiplier! * 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: Text(
                    'Enter the code sent to your email to verify.\nFor testing, enter 234567',
                    style: AppFonts.heading3,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 5,
                ),
                Icon(
                  Icons.email,
                  size: SizeConfig.imageSizeMultiplier! * 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 5,
                ),
                Form(
                  key: _verifyEmailFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPinBoxes(
                        onSaved: (value) {
                          token = value!;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 4,
                      ),
                      CustomButton(
                        text: 'Confirm',
                        onpressed: _verifyEmail,
                        width: width,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier!,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.login),
                            child: Text('Cancel', style: AppFonts.body1)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
