import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../viewmodels/main_viewmodel.dart';

class DynamicBottomNavBar extends StatelessWidget {
  const DynamicBottomNavBar({Key? key}) : super(key: key);

  String _getActiveText(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Hotels Resort';
      case 2:
        return 'Booking Hotel';
      case 3:
        return 'Account';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        int currentIndex = 0;
        if (viewModel.currentScreen == AppScreen.dashboard) currentIndex = 0;
        if (viewModel.currentScreen == AppScreen.details) currentIndex = 1;
        if (viewModel.currentScreen == AppScreen.calendar) currentIndex = 2;
        if (viewModel.currentScreen == AppScreen.account) currentIndex = 3;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.navBackground.withOpacity(0.85),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                title: _getActiveText(0),
                index: 0,
                currentIndex: currentIndex,
                onTap: () => viewModel.navigateTo(AppScreen.dashboard),
              ),
              _NavItem(
                icon: Icons.flight_takeoff,
                title: _getActiveText(1),
                index: 1,
                currentIndex: currentIndex,
                onTap: () => viewModel.navigateTo(AppScreen.details),
              ),
              _NavItem(
                icon: Icons.calendar_today_outlined,
                title: _getActiveText(2),
                index: 2,
                currentIndex: currentIndex,
                onTap: () => viewModel.navigateTo(AppScreen.calendar),
              ),
              _NavItem(
                icon: Icons.person,
                title: _getActiveText(3),
                index: 3,
                currentIndex: currentIndex,
                onTap: () => viewModel.navigateTo(AppScreen.account),
                isProfile: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;
  final bool isProfile;

  const _NavItem({
    required this.icon,
    required this.title,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 20 : (isProfile ? 4 : 12),
          vertical: isProfile ? 4 : 12,
        ),
        decoration: BoxDecoration(
          color:
              isActive ? AppColors.accentBlue : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isProfile
                ? const CircleAvatar(
                    radius: 20, // Large image (40x40)
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  )
                : Icon(
                    icon,
                    color: isActive ? Colors.white : AppColors.inactiveNavIcon,
                    size: 24,
                  ),

            // Text smoothly animates in and out using AnimatedSize
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: isActive
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
