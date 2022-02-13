import 'package:flutter/material.dart';
import 'package:sportconnect/config/size-config.dart';
import 'package:sportconnect/constants/app_colors.dart';

class CustomSearchInput extends StatelessWidget {
  const CustomSearchInput({
    Key? key,
    required this.searchController,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController searchController;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: AppColors.primaryColor))),
      padding: EdgeInsets.only(top: SizeConfig.heightMultiplier!),
      child: TextField(
          style: const TextStyle(fontFamily: 'Inter'),
          controller: searchController,
          decoration: const InputDecoration(
              labelText: 'Search',
              focusColor: AppColors.primaryColor,
              labelStyle: TextStyle(color: AppColors.primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.primaryColor)),
          onChanged: onChanged),
    );
  }
}
