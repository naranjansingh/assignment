import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../viewmodels/main_viewmodel.dart';
import 'menu_list_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    
    // Static background drawer for the 3D Zoom effect
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerContentWidth = screenWidth * 0.68;

    return Container(
      width: screenWidth,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        gradient: RadialGradient(
          center: const Alignment(-0.5, 0.5),
          radius: 1.5,
          colors: [
            AppColors.accentBlue.withOpacity(0.1),
            AppColors.background,
          ],
        ),
      ),
      child: SafeArea(
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: drawerContentWidth,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24), // No right padding so active item can touch the edge
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Profile Header
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Alice Premium',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Toronto, Canada',
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => viewModel.toggleDrawer(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Account Setting
                  _buildSectionTitle('Account Setting'),
                  ...viewModel.accountSettings.map((item) => MenuListItem(
                    item: item,
                    isActive: viewModel.activeMenuId == item.id,
                    onTap: () => viewModel.setActiveMenu(item.id),
                  )),
                  
                  const SizedBox(height: 24),
                  _buildSectionTitle('Listing Setting'),
                  ...viewModel.listingSettings.map((item) => MenuListItem(
                    item: item,
                    isActive: viewModel.activeMenuId == item.id,
                    onTap: () => viewModel.setActiveMenu(item.id),
                  )),
                  
                  const SizedBox(height: 24),
                  _buildSectionTitle('App Setting'),
                  ...viewModel.appSettings.map((item) => MenuListItem(
                    item: item,
                    isActive: viewModel.activeMenuId == item.id,
                    onTap: () => viewModel.setActiveMenu(item.id),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
