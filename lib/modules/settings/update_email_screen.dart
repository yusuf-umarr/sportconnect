import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/constants/widgets/custom_background.dart';
import 'package:sportconnect/constants/widgets/custom_button.dart';
import 'package:sportconnect/constants/widgets/custom_input.dart';
import 'package:sportconnect/constants/widgets/error.dart';
import 'package:sportconnect/modules/auth/models/user_model.dart';
import 'package:sportconnect/modules/auth/user_preference.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({Key? key}) : super(key: key);

  @override
  _UpdateEmailScreenState createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  final _updateEmailFormKey = GlobalKey<FormState>();
  dynamic user;

  final Map<String, dynamic> _updateEmailData = {
    'oldemail': '',
    'newemail': '',
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

  Future<void> _updateEmail() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(
          'Its looks like you\'re offline. Please, check your internet connection and try again');
    } else {
      if (!_updateEmailFormKey.currentState!.validate()) {
        // Invalid !
        return;
      }
      _updateEmailFormKey.currentState!.save();
      if (user.email != _updateEmailData['oldemail']) {
        _showErrorDialog('Incorrect old email!');
      } else {
        await UserPreferences().saveUser(
          User(
            email: _updateEmailData['newemail'],
            phoneNumber: user.phoneNumber,
            interest: user.interest,
            password: user.password,
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
        child: Container(
          padding: EdgeInsets.only(
              left: width * 0.05,
              right: width * 0.05,
              top: SizeConfig.heightMultiplier! * 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.mail,
                  size: SizeConfig.imageSizeMultiplier! * 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 8,
                ),
                Form(
                  key: _updateEmailFormKey,
                  child: Column(
                    children: [
                      CustomInput(
                        hint: 'example@gmail.com',
                        label: 'Old Email',
                        onSaved: (value) {
                          _updateEmailData['oldemail'] = value!;
                        },
                        validator: _emailValidator,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 3,
                      ),
                      CustomInput(
                        hint: 'example@gmail.com',
                        label: 'New Email',
                        onSaved: (value) {
                          _updateEmailData['newemail'] = value!;
                        },
                        validator: _emailValidator,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 8,
                ),
                CustomButton(
                  text: 'Update Email',
                  onpressed: _updateEmail,
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
