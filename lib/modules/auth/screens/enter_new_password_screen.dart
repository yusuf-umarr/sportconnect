import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/constants/widgets/custom_background.dart';
import 'package:sportconnect/constants/widgets/custom_button.dart';
import 'package:sportconnect/constants/widgets/custom_input.dart';
import 'package:sportconnect/constants/widgets/custom_pin_boxes.dart';
import 'package:sportconnect/constants/widgets/error.dart';
import 'package:sportconnect/modules/auth/models/user_model.dart';
import 'package:sportconnect/modules/auth/user_preference.dart';

class EnterNewPasswordScreen extends StatefulWidget {
  const EnterNewPasswordScreen({Key? key}) : super(key: key);

  @override
  _EnterNewPasswordScreenState createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  final _resetPasswordFormKey = GlobalKey<FormState>();
  bool obsecurePassword = true;
  bool obsecureConfirmPassword = true;

  final Map<String, dynamic> _resetPasswordData = {
    'token': '',
    'password': '',
    'confirmpassword': '',
  };

  String? _passwordValidator(value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8';
    }
    return null;
  }

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

  Future<void> _resetPassword() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(
          'Its looks like you\'re offline. Please, check your internet connection and try again');
    } else {
      if (!_resetPasswordFormKey.currentState!.validate()) {
        // Invalid !
        return;
      }
      _resetPasswordFormKey.currentState!.save();
      if (_resetPasswordData['password'] !=
          _resetPasswordData['confirmpassword']) {
        _showErrorDialog('Passwords don\'t match!');
      } else if (_resetPasswordData['token'] == '') {
        _showErrorDialog('Token is required!');
      } else if (_resetPasswordData['token'].length != 6) {
        _showErrorDialog('Token must be 6 digits!');
      } else if (_resetPasswordData['token'] != '234567') {
        _showErrorDialog('Invalid token!');
      } else {
        final user = await UserPreferences().getUser();
        await UserPreferences().saveUser(
          User(
            email: user.email,
            phoneNumber: user.phoneNumber,
            interest: user.interest,
            password: _resetPasswordData['password'],
          ),
        );
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
              top: SizeConfig.heightMultiplier! * 8),
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
                  Icons.lock,
                  size: SizeConfig.imageSizeMultiplier! * 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 5,
                ),
                Form(
                  key: _resetPasswordFormKey,
                  child: Column(
                    children: [
                      CustomPinBoxes(
                        onSaved: (value) {
                          _resetPasswordData['token'] = value!;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 3,
                      ),
                      CustomInput(
                        hint: '*********',
                        label: 'New Password',
                        obsecure: obsecurePassword,
                        onSaved: (value) {
                          _resetPasswordData['password'] = value!;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            obsecurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obsecurePassword = !obsecurePassword;
                            });
                          },
                        ),
                        validator: _passwordValidator,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 3,
                      ),
                      CustomInput(
                        obsecure: obsecureConfirmPassword,
                        hint: '*********',
                        label: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obsecureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obsecureConfirmPassword =
                                  !obsecureConfirmPassword;
                            });
                          },
                        ),
                        validator: _passwordValidator,
                        onSaved: (value) {
                          _resetPasswordData['confirmpassword'] = value!;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 5,
                ),
                CustomButton(
                  text: 'Reset',
                  onpressed: _resetPassword,
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
        ),
      ),
    );
  }
}
