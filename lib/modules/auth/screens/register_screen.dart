import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/constants/widgets/custom_background.dart';
import 'package:sportconnect/constants/widgets/custom_button.dart';
import 'package:sportconnect/constants/widgets/custom_cupertino_picker_container.dart';
import 'package:sportconnect/constants/widgets/custom_input.dart';
import 'package:sportconnect/constants/widgets/custom_select_bottom_sheet.dart';
import 'package:sportconnect/constants/widgets/error.dart';
import 'package:sportconnect/modules/auth/models/user_model.dart';
import 'package:sportconnect/modules/auth/user_preference.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  bool obsecurePassword = true;
  String selectedSport = '';
  final List<String> sports = [
    'Football',
    'Basketball',
    'Volleyball',
    'Rugby',
    'Tennis'
  ];

  final Map<String, dynamic> _registerData = {
    'email': '',
    'phoneNumber': '',
    'password': '',
    'sport': '',
  };

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

  String? _phoneValidator(value) {
    if (value.isEmpty) {
      return 'Please enter phoneNumber';
    }
    if (value.length < 11) {
      return 'phoneNumber must be 11 digits';
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

  Future<void> _register() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(
          'It looks like you\'re offline. Please, check your internet connection and try again');
    } else {
      if (!_registerFormKey.currentState!.validate()) {
        // Invalid !
        return;
      }
      _registerFormKey.currentState!.save();
      if (_registerData['sport'] == '') {
        _showErrorDialog('Please select your favorite sport!');
      } else {
        await UserPreferences().saveUser(
          User(
            email: _registerData['email'],
            phoneNumber: _registerData['phoneNumber'],
            interest: _registerData['sport'],
            password: _registerData['password'],
          ),
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.verifyEmail);
      }
    }
  }

  void setUserSport(String sport) {
    setState(() {
      selectedSport = sport;
    });
  }

  void _showSports() {
    if (Platform.isIOS) {
      setState(() {
        setUserSport(sports[0]);
        _registerData['sport'] = sports[0];
      });
    }

    showModalBottomSheet<dynamic>(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier! * 3,
                    vertical: SizeConfig.heightMultiplier! * 2,
                  ),
                  child: Platform.isIOS
                      ? CupertinoPickerContainer(
                          containerHeight: SizeConfig.heightMultiplier! * 30,
                          listHeight: SizeConfig.heightMultiplier! * 18,
                          color: AppColors.primaryColor,
                          child: CupertinoPicker(
                              itemExtent: 32,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  setUserSport(sports[index]);
                                  _registerData['sport'] = sports[index];
                                });
                              },
                              children:
                                  sports.map((sport) => Text(sport)).toList()),
                        )
                      : SizedBox(
                          height: SizeConfig.heightMultiplier! * 30,
                          child: ListView.builder(
                            itemCount: sports.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    setUserSport(sports[index]);
                                    _registerData['sport'] = sports[index];
                                  });

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: selectedSport == sports[index]
                                          ? Border.all(
                                              width: 2,
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.8))
                                          : null),
                                  child: ListTile(
                                    title: Center(
                                      child: Text(sports[index],
                                          style: AppFonts.heading4),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return CustomBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: height,
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Register', style: AppFonts.heading2),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier! * 2,
                    horizontal: SizeConfig.widthMultiplier! * 2,
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Form(
                      key: _registerFormKey,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier! * 5,
                          ),
                          CustomInput(
                            hint: 'example@gmail.com',
                            label: 'Email',
                            validator: _emailValidator,
                            onSaved: (value) {
                              _registerData['email'] = value!;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier! * 3,
                          ),
                          CustomInput(
                            hint: '08074655636',
                            label: 'Phone Number',
                            validator: _phoneValidator,
                            type: 'number',
                            onSaved: (value) {
                              _registerData['phoneNumber'] = value!;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier! * 3,
                          ),
                          CustomSelectBottomSheet(
                            value: _registerData['sport'],
                            hint: 'Select favorite sport...',
                            onPressed: () {
                              _showSports();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier! * 3,
                          ),
                          CustomInput(
                            obsecure: obsecurePassword,
                            hint: '*********',
                            label: 'Password',
                            onSaved: (value) {
                              _registerData['password'] = value!;
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
                            height: SizeConfig.heightMultiplier! * 10,
                          ),
                          CustomButton(
                            text: 'Register',
                            onpressed: _register,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already Have an Account?',
                                style: AppFonts.body3,
                              ),
                              TextButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed(AppRoutes.login),
                                  child: const Text('Login',
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Outfit',
                                          fontSize: 15))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
