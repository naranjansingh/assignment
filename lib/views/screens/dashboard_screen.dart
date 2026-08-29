import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../viewmodels/hotel_viewmodel.dart';
import '../../viewmodels/main_viewmodel.dart';
import '../widgets/hotel/hotel_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentBlue.withOpacity(0.15),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Good Morning\nPrabhat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            context.read<MainViewModel>().toggleDrawer();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        icon: Icon(Icons.search,
                            color: AppColors.secondaryText, size: 20),
                        hintText: 'Search Location',
                        hintStyle: TextStyle(
                            color: AppColors.secondaryText, fontSize: 14),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.mic,
                            color: AppColors.secondaryText, size: 20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Hotel Cards List
                Expanded(
                  child: Consumer<HotelViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100), // Space for nav bar
                        itemCount: viewModel.hotels.length,
                        itemBuilder: (context, index) {
                          final hotel = viewModel.hotels[index];
                          return HotelCard(
                            hotel: hotel,
                            onTap: () {
                              viewModel.selectHotel(hotel);
                              context
                                  .read<MainViewModel>()
                                  .navigateTo(AppScreen.details);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
