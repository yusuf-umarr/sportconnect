import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/modules/auth/user_preference.dart';
import 'package:sportconnect/modules/home/models/settings_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  dynamic user;
  bool loading = false;
  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  Future<void> fetchUser() async {
    setState(() {
      loading = true;
    });
    user = await UserPreferences().getUser();
    setState(() {
      loading = false;
    });
  }

  void _showLogoutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text('Cancel', style: AppFonts.body1grey),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget confirmButton = TextButton(
      child: Text('Yes', style: AppFonts.heading3),
      onPressed: () {
        Navigator.pop(context, true);
        Navigator.pop(context, true);
      },
    );

    // title
    Widget title = Center(
        child: Text(
      'Sign Out',
      style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.textMultiplier! * 2.2,
          fontFamily: 'Outfit'),
    ));

    // content
    Widget content = Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier! * 3),
        child: Text(
          'Are you sure you want\nto log out?',
          style: AppFonts.body1,
          textAlign: TextAlign.center,
        ));

    // set up the AlertDialog
    dynamic alert = Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  confirmButton,
                  cancelButton,
                ],
              )
            ],
          )
        : AlertDialog(
            title: title,
            content: content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  confirmButton,
                  cancelButton,
                ],
              )
            ],
          );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settings = Settings.settings;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient:
            LinearGradient(colors: [AppColors.primaryColor, Color(0xFF7314B4)]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: SizeConfig.heightMultiplier! * 2),
          margin: EdgeInsets.only(top: SizeConfig.heightMultiplier! * 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height * 0.53,
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier! * 3),
                      itemCount: settings.length,
                      itemBuilder: (BuildContext context, int index) {
                        Setting setting = settings[index];
                        return GestureDetector(
                          onTap: () {
                            if (setting.id == 3) {
                              _showLogoutDialog(context);
                            } else {
                              Navigator.of(context).pushNamed(setting.routeName,
                                  arguments: user);
                            }
                          },
                          child: Container(
                            height: SizeConfig.heightMultiplier! * 8,
                            margin: EdgeInsets.only(
                                top: SizeConfig.heightMultiplier! * 3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                          offset: const Offset(1, 2))
                                    ]),
                                child: Icon(
                                  setting.icon,
                                  color: AppColors.primaryColor,
                                  size: SizeConfig.imageSizeMultiplier! * 4,
                                ),
                              ),
                              title: Text(
                                setting.title,
                                style: TextStyle(
                                  color: const Color(0xFF353F58),
                                  fontSize: SizeConfig.textMultiplier! * 1.8,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined,
                                  color: AppColors.primaryColor,
                                  size: SizeConfig.imageSizeMultiplier! * 4),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
