import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';
import 'package:sportconnect/constants/app_images.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/constants/widgets/custom_button.dart';
import 'package:sportconnect/constants/widgets/custom_outline_button.dart';
import 'package:sportconnect/modules/walk-through/walk_through_model.dart';

class WalkThroughScreen extends StatefulWidget {
  static const routeName = '/walk-through';

  const WalkThroughScreen({Key? key}) : super(key: key);
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  int sliderIndex = 0;
  @override
  Widget build(BuildContext context) {
    final walkThroughItem = WalkThroughItems.loadWalkThroughItem();
    var items = <Widget>[];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    for (var item in walkThroughItem) {
      items.add(Stack(
        children: [
          Image.asset(
            item.image,
            fit: BoxFit.fitHeight,
            width: width,
            height: height,
          ),
          Image.asset(
            AppImages.onboardingShade,
            fit: BoxFit.fitWidth,
            width: width,
            height: height,
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.only(
                right: width * 0.03, left: width * 0.03, bottom: height * 0.35),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(item.title, style: AppFonts.heading2white),
                  SizedBox(
                    height: SizeConfig.textMultiplier! * 2,
                  ),
                  SizedBox(
                    width: width * 0.75,
                    child: Text(
                      item.subtitle,
                      style: AppFonts.bodywhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
          ))
        ],
      ));
    }

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(children: [
          CarouselSlider(
            items: items,
            //Slider Container properties
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
              pageSnapping: true,
              //enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  sliderIndex = index;
                });
              },
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  right: width * 0.03,
                  left: width * 0.03,
                  bottom: height * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(
                    child: SizedBox(
                      width: SizeConfig.widthMultiplier! * 40,
                      height: SizeConfig.heightMultiplier! * 0.5,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                width: SizeConfig.widthMultiplier! * 7,
                                height: SizeConfig.heightMultiplier! * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: sliderIndex != i
                                      ? Border.all(
                                          width: 1, color: Colors.black38)
                                      : null,
                                  color: sliderIndex == i
                                      ? AppColors.primaryColor
                                      : Colors.white.withOpacity(0.6),
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomButton(
                    text: 'Sign up',
                    onpressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.register),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomOutlineButton(
                    text: 'Sign in',
                    onpressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.login),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class NavigationContainer extends StatelessWidget {
  const NavigationContainer({
    Key? key,
    required this.width,
    required this.icon,
    required this.title,
    required this.routeName,
  }) : super(key: key);

  final double width;
  final IconData icon;
  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(routeName),
      child: Container(
        height: SizeConfig.heightMultiplier! * 10,
        width: width,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(247, 147, 76, 0.2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: SizeConfig.imageSizeMultiplier! * 8, color: Colors.white),
            SizedBox(
              height: SizeConfig.heightMultiplier! * 1,
            ),
            Text(
              title,
              style: AppFonts.body1white,
            )
          ],
        ),
      ),
    );
  }
}
