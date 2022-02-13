import 'package:flutter/material.dart';
import 'package:sportconnect/modules/auth/screens/enter_new_password_screen.dart';
import 'package:sportconnect/modules/auth/screens/forgot_password_screen.dart';
import 'package:sportconnect/modules/auth/screens/login_screen.dart';
import 'package:sportconnect/modules/auth/screens/register_screen.dart';
import 'package:sportconnect/modules/auth/screens/verify_email_screen.dart';
import 'package:sportconnect/modules/home/home_screen.dart';
import 'package:sportconnect/modules/settings/change_password_screen.dart';
import 'package:sportconnect/modules/settings/update_email_screen.dart';
import 'package:sportconnect/modules/walk-through/walk_through_screen.dart';

class AppRoutes {
  // WALKTHROUGH
  static const walkThrough = '/walk-through';

  // AUTH
  static const register = '/register';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const enterNewPassword = '/enter-new-password';
  static const verifyEmail = '/verify-email';

  // HOME
  static const home = '/home';

  // SETTINGS
  static const changePassword = '/change-password';
  static const updateEmail = '/update-email';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      // WELCOME
      walkThrough: (context) => const WalkThroughScreen(),

      // AUTH
      register: (context) => const RegisterScreen(),
      login: (context) => const LoginScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      enterNewPassword: (context) => const EnterNewPasswordScreen(),
      verifyEmail: (context) => const VerifyEmailScreen(),

      // HOME
      home: (context) => const HomeScreen(),

      // SETTINGS
      changePassword: (context) => const ChangePasswordScreen(),
      updateEmail: (context) => const UpdateEmailScreen(),
    };
  }
}
