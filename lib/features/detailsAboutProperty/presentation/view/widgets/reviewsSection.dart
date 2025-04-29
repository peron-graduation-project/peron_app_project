import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/review.dart';

class ReviewsSection extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;

  const ReviewsSection({
    Key? key,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Divider(
            thickness: 0.3,
            color: Colors.grey.shade200,
          ),
          // Header row with title and "View All" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // View All button (Left side)
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReviewsScreen()));
                },
                child: Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: Color(0xff0F7757),
                    fontWeight: FontWeight.bold,
                    fontSize: smallFontSize,
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                ),
              ),
              // Section title (Right side)
              Text(
                'آراء العملاء',
                style: TextStyle(
                  fontSize: fontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.primaryFontFamily,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          SizedBox(height: 15),
          _buildReviewItem(
            'Eid Said',
            5.0,
            'مكان هادئ مناسب للعائلة',
            'assets/images/profile_pic.jpg',
            'منذ يومين',
          ),
        ],
      ),
    );
  }

  // Modified review item with better alignment
  Widget _buildReviewItem(String name, double rating, String comment,
      String imagePath, String timeAgo) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Single row with profile image, name, rating and comment
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image
              CircleAvatar(
                radius: fontSize,
                backgroundImage: AssetImage(imagePath),
              ),
              SizedBox(width: 10),
              // Content column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Name
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 4),
                    // Stars row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: Color(0xff0F7757),
                          size: smallFontSize * 1.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    // Comment text
                    Text(
                      comment,
                      style: TextStyle(
                        fontSize: smallFontSize,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Time ago text - Aligned to the left
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              timeAgo,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: smallFontSize * 0.9,
                fontFamily: Fonts.primaryFontFamily,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}