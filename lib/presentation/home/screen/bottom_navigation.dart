import 'package:flutter/material.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/presentation/history/screen/history_screen.dart';
import 'package:rebuild_bank_sampah/presentation/home/screen/home_screen.dart';
import 'package:rebuild_bank_sampah/presentation/home/widget/nav_items_widget.dart';
import 'package:rebuild_bank_sampah/presentation/profile/screen/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: AppSizes.symmetricPadding(
            vertical: AppSizes.s14, horizontal: AppSizes.s15),
        decoration: BoxDecoration(
          color: AppColors.colorBaseWhite,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.colorSecondary500.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItems(
              label: AppConstants.LABEL_HOME,
              iconPath: Assets.icons.home.path,
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItems(
              label: AppConstants.LABEL_HISTORY,
              iconPath: Assets.icons.history.path,
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            NavItems(
              label: AppConstants.LABEL_PROFILE,
              iconPath: Assets.icons.profile.path,
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
