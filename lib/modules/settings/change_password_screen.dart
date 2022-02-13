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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _changePasswordFormKey = GlobalKey<FormState>();
  bool obsecureOldPassword = true;
  bool obsecureNewPassword = true;
  bool obsecureConfirmPassword = true;
  dynamic user;

  final Map<String, dynamic> _resetPasswordData = {
    'oldpassword': '',
    'newpassword': '',
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

  Future<void> _changePassword() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(
          'Its looks like you\'re offline. Please, check your internet connection and try again');
    } else {
      if (!_changePasswordFormKey.currentState!.validate()) {
        // Invalid !
        return;
      }
      _changePasswordFormKey.currentState!.save();
      if (_resetPasswordData['oldpassword'] != user.password) {
        _showErrorDialog('Old Password incorrect!');
      } else if (_resetPasswordData['newpassword'] !=
          _resetPasswordData['confirmpassword']) {
        _showErrorDialog('New Passwords don\'t match!');
      } else {
        await UserPreferences().saveUser(
          User(
            email: user.email,
            phoneNumber: user.phoneNumber,
            interest: user.interest,
            password: _resetPasswordData['newpassword'],
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    user = ModalRoute.of(context)!.settings.arguments;
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
                Icon(
                  Icons.lock,
                  size: SizeConfig.imageSizeMultiplier! * 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 5,
                ),
                Form(
                  key: _changePasswordFormKey,
                  child: Column(
                    children: [
                      CustomInput(
                        hint: '*********',
                        label: 'Old Password',
                        obsecure: obsecureOldPassword,
                        onSaved: (value) {
                          _resetPasswordData['oldpassword'] = value!;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            obsecureOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obsecureOldPassword = !obsecureOldPassword;
                            });
                          },
                        ),
                        validator: _passwordValidator,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 3,
                      ),
                      CustomInput(
                        hint: '*********',
                        label: 'New Password',
                        obsecure: obsecureNewPassword,
                        onSaved: (value) {
                          _resetPasswordData['newpassword'] = value!;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            obsecureNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obsecureNewPassword = !obsecureNewPassword;
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
                  text: 'Change',
                  onpressed: _changePassword,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier!,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
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
