import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/constants/widgets/custom_background.dart';
import 'package:sportconnect/constants/widgets/custom_button.dart';
import 'package:sportconnect/constants/widgets/custom_input.dart';
import 'package:sportconnect/constants/widgets/error.dart';
import 'package:sportconnect/modules/auth/user_preference.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();

  String email = '';

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

  String? _emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter email';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Invalid Email';
    }
    return null;
  }

  Future<void> _requestOTP() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(
          'Its looks like you\'re offline. Please, check your internet connection and try again');
    } else {
      if (!_forgotPasswordFormKey.currentState!.validate()) {
        // Invalid !
        return;
      }
      _forgotPasswordFormKey.currentState!.save();
      final user = await UserPreferences().getUser();
      if (user.email != email) {
        _showErrorDialog('Incorrect email!');
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.enterNewPassword);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomBackground(
        child: Container(
          padding: EdgeInsets.only(
              left: width * 0.05,
              right: width * 0.05,
              top: SizeConfig.heightMultiplier! * 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.lock,
                  size: SizeConfig.imageSizeMultiplier! * 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 8,
                ),
                Form(
                  key: _forgotPasswordFormKey,
                  child: CustomInput(
                    hint: 'example@gmail.com',
                    label: 'Email',
                    onSaved: (value) {
                      email = value!;
                    },
                    validator: _emailValidator,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 8,
                ),
                CustomButton(
                  text: 'Receive OTP',
                  onpressed: _requestOTP,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 2,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Back', style: AppFonts.body1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
