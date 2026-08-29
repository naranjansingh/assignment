import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_app/views/screens/account_screen.dart';
import 'package:settings_app/views/widgets/common/dynamic_nav_bar.dart';
import 'package:settings_app/views/widgets/drawer/custom_drawer.dart';

import 'core/theme/app_theme.dart';
import 'viewmodels/hotel_viewmodel.dart';
import 'viewmodels/main_viewmodel.dart';
import 'views/screens/calendar_screen.dart';
import 'views/screens/dashboard_screen.dart';
import 'views/screens/hotel_detail_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_) => HotelViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        final isDrawerOpen = viewModel.isDrawerOpen;
        final screenWidth = MediaQuery.of(context).size.width;
        final drawerWidth = screenWidth * 0.68; // 68% of screen

        Widget screen;
        switch (viewModel.currentScreen) {
          case AppScreen.dashboard:
            screen = const DashboardScreen();
            break;
          case AppScreen.details:
            screen = const HotelDetailScreen();
            break;
          case AppScreen.calendar:
            screen = const CalendarScreen();
            break;
          case AppScreen.account:
            screen = const AccountScreen();
            break;
        }

        return Scaffold(
          backgroundColor: const Color(0xFF0F1014), // Dark drawer background
          body: Stack(
            children: [
              // 1. Drawer Background
              const CustomDrawer(),

              // 2. Animated Main Content
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                transformAlignment: Alignment
                    .centerLeft, // This makes it scale down perfectly centered vertically
                transform: Matrix4.identity()
                  ..translate(isDrawerOpen ? drawerWidth : 0.0, 0.0)
                  ..scale(isDrawerOpen ? 0.90 : 1.0),
                decoration: BoxDecoration(
                  borderRadius: isDrawerOpen
                      ? BorderRadius.circular(40)
                      : BorderRadius.zero,
                  boxShadow: isDrawerOpen
                      ? [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 30)
                        ]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: isDrawerOpen
                      ? BorderRadius.circular(40)
                      : BorderRadius.zero,
                  child: Stack(
                    children: [
                      screen,

                      // Overlay to intercept taps and close drawer
                      if (isDrawerOpen)
                        GestureDetector(
                          onTap: () => viewModel.toggleDrawer(),
                          child: Container(color: Colors.transparent),
                        ),

                      // 3. Floating Bottom Nav Bar
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: DynamicBottomNavBar(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
