import 'package:flutter/material.dart';

import '../data/models/menu_item_model.dart';

enum AppScreen { dashboard, details, calendar, account }

class MainViewModel extends ChangeNotifier {
  // Navigation State
  AppScreen _currentScreen = AppScreen.dashboard;
  AppScreen get currentScreen => _currentScreen;

  void navigateTo(AppScreen screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  // Drawer State
  bool _isDrawerOpen = false;
  bool get isDrawerOpen => _isDrawerOpen;

  void toggleDrawer() {
    _isDrawerOpen = !_isDrawerOpen;
    notifyListeners();
  }

  // Active Menu Item State
  String _activeMenuId = 'payment';
  String get activeMenuId => _activeMenuId;

  void setActiveMenu(String id) {
    _activeMenuId = id;
    notifyListeners();
  }

  // Drawer Menu Items Data (Used in CustomDrawer)
  final List<MenuItemModel> accountSettings = [
    MenuItemModel(
        id: 'notification',
        title: 'Notification',
        icon: Icons.notifications_none,
        badgeText: '12'),
    MenuItemModel(id: 'payment', title: 'Payment', icon: Icons.payment),
    MenuItemModel(id: 'translate', title: 'Translate', icon: Icons.translate),
    MenuItemModel(id: 'privacy', title: 'Privacy', icon: Icons.lock_outline),
  ];

  final List<MenuItemModel> listingSettings = [
    MenuItemModel(id: 'listing', title: 'Listing', icon: Icons.list_alt),
    MenuItemModel(id: 'host', title: 'Host', icon: Icons.person_outline),
  ];

  final List<MenuItemModel> appSettings = [
    MenuItemModel(
        id: 'dark_mode', title: 'Dark Mode', icon: Icons.dark_mode_outlined),
    MenuItemModel(id: 'update', title: 'Update', icon: Icons.system_update_alt),
  ];

  // Settings Items for Account Screen (Matches Screenshot 4)
  final List<dynamic> settingsItems = [
    {
      'icon': Icons.person_outline,
      'title': 'Edit Profile',
      'subtitle': 'Manage your details and profile',
    },
    {
      'icon': Icons.account_circle_outlined,
      'title': 'Account',
      'subtitle': 'Manage account and login settings',
    },
    {
      'icon': Icons.notifications_none,
      'title': 'Notification',
      'subtitle': 'Manage your notification preferences',
    },
    {
      'icon': Icons.color_lens_outlined,
      'title': 'Appearance',
      'subtitle': 'Customize your app experience',
    },
    {
      'icon': Icons.help_outline,
      'title': 'Help & Feedback',
      'subtitle': 'Get help or share feedback',
    },
    {
      'icon': Icons.group_add_outlined,
      'title': 'Invite a friend',
      'subtitle': 'Invite friends to UseRole app',
    },
    {
      'icon': Icons.lock_outline,
      'title': 'Privacy & Security',
      'subtitle': 'Manage privacy and data settings',
    },
    {
      'icon': Icons.credit_card,
      'title': 'Subscription',
      'subtitle': 'Manage your plan and billing',
      'hasBadge': true,
      'badgeText': 'Coming Soon',
    },
  ];
}
