import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/modules/auth/user_preference.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                SizedBox(
                  height: SizeConfig.heightMultiplier! * 6,
                ),
                Container(
                    height: SizeConfig.heightMultiplier! * 62,
                    margin: EdgeInsets.only(
                        bottom: SizeConfig.heightMultiplier! * 3),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1))
                        ]),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: Image.network(
                                'https://blog.loveawake.com/wp-content/uploads/2019/07/jonas-kakaroto-KIPqvvTOC1s-unsplash.jpg',
                                height: SizeConfig.heightMultiplier! * 36,
                                width: size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.heightMultiplier! * 3,
                                  left: size.width * 0.05,
                                  right: size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  loading
                                      ? SpinKitChasingDots(
                                          color: AppColors.primaryColor,
                                          size:
                                              SizeConfig.imageSizeMultiplier! *
                                                  4,
                                        )
                                      : Text('Interest:  ${user.interest}',
                                          style: AppFonts.body1),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier! * 2,
                                  ),
                                  Text(
                                      'Sam Johnson has spent his life using his personal and career experiences to help his clients overcome post-traumatic stress disorder and provide them with the support they need when their life seems to be more than they can handle.',
                                      style: AppFonts.body2),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: SizeConfig.heightMultiplier! * 11,
                          width: size.width,
                          margin: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier! * 34,
                              left: size.width * 0.05),
                          child: Row(
                            children: [
                              Container(
                                height: SizeConfig.heightMultiplier! * 11,
                                width: SizeConfig.widthMultiplier! * 20,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                      'https://images.unsplash.com/photo-1618535263244-0185e50e667e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier! * 2,
                              ),
                              loading
                                  ? SpinKitChasingDots(
                                      color: AppColors.primaryColor,
                                      size: SizeConfig.imageSizeMultiplier! * 4,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(user.phoneNumber,
                                            style: AppFonts.heading2s),
                                        Text(
                                          user.email,
                                          style: AppFonts.body1grey,
                                        )
                                      ],
                                    )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
