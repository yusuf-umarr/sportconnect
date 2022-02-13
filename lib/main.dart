import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_routes.dart';
import 'package:sportconnect/modules/walk-through/walk_through_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Sport Task',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const WalkThroughScreen(),
          routes: AppRoutes.routes(),
        );
      });
    });
  }
}
