import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../viewmodels/hotel_viewmodel.dart';
import '../../viewmodels/main_viewmodel.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({Key? key}) : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Consumer<HotelViewModel>(
            builder: (context, viewModel, child) {
              final hotel = viewModel.selectedHotel ?? viewModel.hotels.first;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // 1. Top Images PageView with extended height
                        SizedBox(
                          height: 380, // Extended height so it goes under the rounded corners
                          width: double.infinity,
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                            },
                            children: [
                              Image.asset(
                                hotel.imageUrl,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/hotel_2.jpg',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),

                        // 2. Back button
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.black45,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                                onPressed: () => context
                                    .read<MainViewModel>()
                                    .navigateTo(AppScreen.dashboard),
                              ),
                            ),
                          ),
                        ),

                        // 3. Detail Content overlapping image
                        Container(
                          margin: const EdgeInsets.only(top: 350),
                          decoration: const BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image Carousel Indicators (Figma Orange)
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 24, bottom: 24),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        width: 16,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: _currentImageIndex == 0 
                                              ? const Color(0xFFFF8A00) // Exact orange from Figma
                                              : Colors.white.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        width: 16,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: _currentImageIndex == 1 
                                              ? const Color(0xFFFF8A00) 
                                              : Colors.white.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Inner Host Info Card
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 24,
                                          backgroundImage: AssetImage(
                                              'assets/images/avatar.jpg'),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            hotel.hostName.replaceAll(', ',
                                                ',\n'), // Split into two lines like screenshot
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.white, size: 16),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${hotel.rating}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text('|',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.secondaryText,
                                                  fontSize: 13)),
                                        ),
                                        Text(
                                          '1,648 reviews',
                                          style: const TextStyle(
                                              color: AppColors.primaryText,
                                              fontSize: 13),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text('|',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.secondaryText,
                                                  fontSize: 13)),
                                        ),
                                        Expanded(
                                          child: Text(
                                            hotel.availableDates,
                                            style: const TextStyle(
                                                color: AppColors.primaryText,
                                                fontSize: 13),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: AppColors
                                                .accentBlue, // Solid blue background
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                              Icons.notifications_active,
                                              color: Colors.white,
                                              size:
                                                  18), // Bell/notification icon
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Text(
                                              hotel.address
                                                  .replaceAll(', ', ',\n'),
                                              style: const TextStyle(
                                                color: AppColors.secondaryText,
                                                fontSize: 13,
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),

                              // Description with Glow
                              Stack(
                                children: [
                                  Positioned(
                                    left: -20,
                                    bottom: -20,
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            AppColors.accentBlue
                                                .withOpacity(0.2),
                                            Colors.transparent
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Description',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          hotel.description,
                                          style: const TextStyle(
                                            color: AppColors.secondaryText,
                                            height: 1.6,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                  height: 100), // Space for bottom nav
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
