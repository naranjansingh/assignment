import 'package:flutter/material.dart';

class MenuItemModel {
  final String id;
  final String title;
  final IconData icon;
  final String? badgeText;

  MenuItemModel({
    required this.id,
    required this.title,
    required this.icon,
    this.badgeText,
  });
}
