import 'package:flutter/material.dart';

class SettingsItemModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hasBadge;
  final String badgeText;

  SettingsItemModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hasBadge = false,
    this.badgeText = '',
  });
}
