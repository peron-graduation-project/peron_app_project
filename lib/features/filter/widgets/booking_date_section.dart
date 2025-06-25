import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingDateSection extends StatelessWidget {
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final void Function(DateTime? start, DateTime? end) onRangeSelected;

  const BookingDateSection({
    super.key,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double calendarWidth = (screenWidth * 0.8).clamp(306, 380);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "فترة الحجز",
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.headlineMediumColor,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: calendarWidth,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: TableCalendar(
                locale: 'en_US',
                firstDay: DateTime.now().add(const Duration(days: 1)),
                lastDay: DateTime(DateTime.now().year + 1),
                focusedDay:
                    rangeStart ?? DateTime.now().add(const Duration(days: 1)),
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                onRangeSelected: (start, end, _) {
                  onRangeSelected(start, end);
                },
                selectedDayPredicate: (_) => false,
                rangeStartDay: rangeStart,
                rangeEndDay: rangeEnd,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black, 
                  ),
                ),
                calendarStyle: CalendarStyle(
                  rangeStartDecoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  rangeEndDecoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  withinRangeDecoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
