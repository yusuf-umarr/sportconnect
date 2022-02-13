import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/constants/widgets/custom_background.dart';
import 'package:sportconnect/constants/widgets/custom_button.dart';
import 'package:sportconnect/constants/widgets/custom_input.dart';
import 'package:sportconnect/constants/widgets/error.dart';
import 'package:sportconnect/modules/auth/user_preference.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  bool obsecure = true;

  final Map<String, String> _loginData = {
    'email': '',
    'password': '',
  };

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

  Future<void> _login() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(
          'Its looks like you\'re offline. Please, check your internet connection and try again');
    } else {
      if (!_loginFormKey.currentState!.validate()) {
        // Invalid !
        return;
      }
      _loginFormKey.currentState!.save();
      final user = await UserPreferences().getUser();
      if (user.email == null) {
        _showErrorDialog(
            'You are yet to register, kindly go\n to the registration screen');
      } else if (user.email != _loginData['email'] ||
          user.password != _loginData['password']) {
        _showErrorDialog('Login credentials incorrect!');
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    }
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

  String? _passwordValidator(value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8';
    }
    return null;
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
                Icon(
                  Icons.login,
                  size: SizeConfig.imageSizeMultiplier! * 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: SizeConfig.textMultiplier! * 8,
                ),
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      CustomInput(
                        hint: 'example@gmail.com',
                        label: 'Email',
                        validator: _emailValidator,
                        onSaved: (value) {
                          _loginData['email'] = value!;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.textMultiplier! * 2,
                      ),
                      CustomInput(
                        obsecure: obsecure,
                        hint: '*********',
                        label: 'Password',
                        onSaved: (value) {
                          _loginData['password'] = value!;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                              obsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primaryColor),
                          onPressed: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                        ),
                        validator: _passwordValidator,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.forgotPassword),
                      child: Text('Forgot Password?', style: AppFonts.body1)),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 5,
                ),
                CustomButton(
                  text: 'Log in',
                  onpressed: _login,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier!,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Back To Welcome Screen',
                          style: AppFonts.body1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
