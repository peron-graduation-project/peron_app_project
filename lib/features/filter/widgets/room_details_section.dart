import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';


class RoomDetailsSection extends StatelessWidget {
  final int rooms;
  final int bathrooms;
  final int floors;
  final int rating;
  final ValueChanged<int> onRoomsChanged;
  final ValueChanged<int> onBathroomsChanged;
  final ValueChanged<int> onFloorsChanged;
  final ValueChanged<int> onRatingChanged;

  const RoomDetailsSection({
    super.key,
    required this.rooms,
    required this.bathrooms,
    required this.floors,
    required this.rating,
    required this.onRoomsChanged,
    required this.onBathroomsChanged,
    required this.onFloorsChanged,
    required this.onRatingChanged,
  });

  Widget buildCounter(BuildContext context, String title, int value, ValueChanged<int> onChanged) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = (screenWidth * 0.06).clamp(24, 36); 
    double iconSize = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Tajawal',
              color: AppColors.titleSmallColor,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: IconButton(
                  iconSize: iconSize,
                  icon: Icon(Icons.remove, color: AppColors.titleSmallColor),
                  onPressed: () => onChanged(value > 1 ? value - 1 : value),
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    side: BorderSide(color: AppColors.titleSmallColor, width: 1),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Tajawal',
                    color: AppColors.titleSmallColor,
                  ),
                ),
              ),
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: IconButton(
                  iconSize: iconSize,
                  icon: Icon(Icons.add, color: AppColors.titleSmallColor),
                  onPressed: () => onChanged(value + 1),
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    side: BorderSide(color: AppColors.titleSmallColor, width: 1),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCounter(context, "عدد الغرف", rooms, onRoomsChanged),
        buildCounter(context, "عدد الحمامات", bathrooms, onBathroomsChanged),
        buildCounter(context, "الطابق", floors, onFloorsChanged),
        buildCounter(context, "نقاط التقييم", rating, onRatingChanged),
        const SizedBox(height: 16),
      ],
    );
  }
}
