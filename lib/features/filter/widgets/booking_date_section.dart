import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDateSection extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const BookingDateSection({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double calendarWidth = (screenWidth * 0.8).clamp(306, 380);
    double calendarHeight = 310;

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
                firstDay: DateTime.now(),
                lastDay: DateTime(DateTime.now().year + 1),
                focusedDay: selectedDate ?? DateTime.now(),
                selectedDayPredicate: (day) =>
                    selectedDate != null && isSameDay(selectedDate, day),
                onDaySelected: (selectedDay, _) => onDateSelected(selectedDay),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primaryColor,
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
