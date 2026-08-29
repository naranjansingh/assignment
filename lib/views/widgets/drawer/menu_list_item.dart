import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/menu_item_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../viewmodels/main_viewmodel.dart';

class MenuListItem extends StatelessWidget {
  final MenuItemModel item;
  final bool isActive;
  final VoidCallback onTap;

  const MenuListItem({
    Key? key,
    required this.item,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(
          bottom: 8,
          right: isActive ? 0 : 24, // Touch right edge if active, else normal margin
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.accentBlue : Colors.transparent,
          borderRadius: isActive
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
              : BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: isActive ? AppColors.accentBlue : AppColors.iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.secondaryText,
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (item.badgeText != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                margin: const EdgeInsets.only(right: 8), // Add margin before chevron/edge
                decoration: BoxDecoration(
                  color: AppColors.badgeBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.badgeText!,
                  style: const TextStyle(
                    color: AppColors.badgeText,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Icon(
              Icons.chevron_right,
              color: isActive ? Colors.white.withOpacity(0.7) : AppColors.secondaryText,
              size: 16,
            ),
            if (isActive)
              const SizedBox(width: 24), // Extra padding on right to account for the edge bleed
          ],
        ),
      ),
    );
  }
}
