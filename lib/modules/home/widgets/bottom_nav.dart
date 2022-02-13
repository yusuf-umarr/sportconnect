import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';
import 'package:sportconnect/constants/app_fonts.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTabTapped;

  const BottomNav(this.currentIndex, this.onTabTapped, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isIPad = MediaQuery.of(context).size.shortestSide > 600 ? true : false;
    return BottomNavigationBar(
      elevation: 5,
      currentIndex: currentIndex,
      unselectedLabelStyle: AppFonts.body2,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Outfit',
        fontSize: isIPad ? 16 : 12,
        fontWeight: FontWeight.w700,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: onTabTapped,
      type: BottomNavigationBarType.shifting,
      items: const [
        BottomNavigationBarItem(
          icon: NavIcon(icon: Icons.person, isActive: false),
          label: 'Profile',
          activeIcon: NavIcon(icon: Icons.person, isActive: true),
        ),
        BottomNavigationBarItem(
          icon: NavIcon(icon: Icons.people, isActive: false),
          label: 'Buddies',
          activeIcon: NavIcon(icon: Icons.people, isActive: true),
        ),
        BottomNavigationBarItem(
          icon: NavIcon(icon: Icons.find_in_page, isActive: false),
          label: 'Discover',
          activeIcon: NavIcon(icon: Icons.find_in_page, isActive: true),
        ),
        BottomNavigationBarItem(
          icon: NavIcon(icon: Icons.settings, isActive: false),
          label: 'Settings',
          activeIcon: NavIcon(icon: Icons.settings, isActive: true),
        ),
      ],
    );
  }
}

class NavIcon extends StatelessWidget {
  const NavIcon({
    Key? key,
    required this.icon,
    required this.isActive,
  }) : super(key: key);

  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: isActive ? AppColors.primaryColor : Colors.grey,
      size: SizeConfig.imageSizeMultiplier! * 7,
    );
  }
}
