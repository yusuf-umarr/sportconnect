import 'package:flutter/material.dart';
import 'package:sportconnect/constants/app_routes.dart';

class Setting {
  final int id;
  final String title;
  final IconData icon;
  final String routeName;

  Setting({
    required this.id,
    required this.title,
    required this.icon,
    required this.routeName,
  });
}

class Settings {
  static List<Setting> settings = [
    Setting(
      id: 1,
      title: 'Change Password',
      icon: Icons.lock,
      routeName: AppRoutes.changePassword,
    ),
    Setting(
      id: 2,
      title: 'Update Email',
      icon: Icons.mail,
      routeName: AppRoutes.updateEmail,
    ),
    Setting(
      id: 3,
      title: 'Logout',
      icon: Icons.logout,
      routeName: '',
    ),
  ];
}
