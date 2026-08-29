import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  late PageController _pageController;
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: 1200); // Middle of 2400 months (100 years past/future)
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDateTapped(DateTime date) {
    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        // Start new selection
        _startDate = date;
        _endDate = null;
      } else if (date.isAfter(_startDate!) ||
          date.isAtSameMomentAs(_startDate!)) {
        // Set end date
        _endDate = date;
      } else {
        // Selected earlier date, reset start
        _startDate = date;
      }
    });
  }

  void _previousMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    String titleText = 'Select dates';
    String subtitleText = 'Please select a date range';

    if (_startDate != null && _endDate != null) {
      final difference = _endDate!.difference(_startDate!).inDays;
      titleText = '$difference-night stay';
      subtitleText =
          '${DateFormat('E, MMM d').format(_startDate!)} - ${DateFormat('E, MMM d').format(_endDate!)}';
    } else if (_startDate != null) {
      titleText = 'Select end date';
      subtitleText = DateFormat('E, MMM d').format(_startDate!);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glows to match Figma
          Positioned(
            bottom: -50,
            left: -50,
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
          Positioned(
            top: 50,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentBlue.withOpacity(0.10),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitleText,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _startDate = null;
                                _endDate = null;
                              });
                            },
                            child: const Text(
                              'Cancel Date',
                              style: TextStyle(
                                color: Color(0xFFFF8A00), // Exact Figma orange
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration
                                    .underline, // Underlined as requested
                                decorationColor: Color(0xFFFF8A00),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Calendar Widget
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('MMM yyyy').format(_currentMonth),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 300, // Fixed height for calendar grid
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                final offset = index - 1200;
                                final now = DateTime.now();
                                _currentMonth =
                                    DateTime(now.year, now.month + offset, 1);
                              });
                            },
                            itemBuilder: (context, pageIndex) {
                              final offset = pageIndex - 1200;
                              final now = DateTime.now();
                              final monthDate =
                                  DateTime(now.year, now.month + offset, 1);
                              final daysInMonth = DateUtils.getDaysInMonth(
                                  monthDate.year, monthDate.month);
                              final firstDayOffset =
                                  monthDate.weekday % 7; // 0 = Sunday

                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing:
                                      0, // 0 spacing for continuous background
                                ),
                                itemCount: daysInMonth + firstDayOffset,
                                itemBuilder: (context, index) {
                                  if (index < firstDayOffset) {
                                    return const SizedBox.shrink();
                                  }

                                  final day = index - firstDayOffset + 1;
                                  final currentDate = DateTime(
                                      monthDate.year, monthDate.month, day);

                                  bool isSelected = false;
                                  bool isStart = false;
                                  bool isEnd = false;
                                  bool inBetween = false;

                                  if (_startDate != null) {
                                    if (_endDate != null) {
                                      isStart = currentDate
                                          .isAtSameMomentAs(_startDate!);
                                      isEnd = currentDate
                                          .isAtSameMomentAs(_endDate!);
                                      inBetween =
                                          currentDate.isAfter(_startDate!) &&
                                              currentDate.isBefore(_endDate!);
                                      isSelected =
                                          isStart || isEnd || inBetween;
                                    } else {
                                      isSelected = currentDate
                                          .isAtSameMomentAs(_startDate!);
                                      isStart = isSelected;
                                      isEnd = isSelected;
                                    }
                                  }

                                  return GestureDetector(
                                    onTap: () => _onDateTapped(currentDate),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.accentBlue
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          topLeft: isStart
                                              ? const Radius.circular(30)
                                              : Radius.zero,
                                          bottomLeft: isStart
                                              ? const Radius.circular(30)
                                              : Radius.zero,
                                          topRight: isEnd
                                              ? const Radius.circular(30)
                                              : Radius.zero,
                                          bottomRight: isEnd
                                              ? const Radius.circular(30)
                                              : Radius.zero,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(
                                        top: 4,
                                        bottom: 4,
                                        left: isStart || (!isSelected) ? 4 : 0,
                                        right: isEnd || (!isSelected) ? 4 : 0,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        day.toString(),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : AppColors.secondaryText,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNavArrow(Icons.chevron_left, _previousMonth),
                      const SizedBox(width: 20),
                      _buildNavArrow(Icons.chevron_right, _nextMonth),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavArrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: AppColors.accentBlue,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
