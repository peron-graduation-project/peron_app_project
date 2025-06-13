import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/review.dart';

class ReviewsSection extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;
  final List<Map<String, dynamic>> reviews;

  const ReviewsSection({
    super.key,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
    this.reviews = const [
      {
        'username': 'Eid Said',
        'rating': 5,
        'comment': 'مكان هادئ مناسب للعائلة',
        'timeAgo': 'منذ يومين',
        'avatarUrl': 'assets/images/profile_pic.jpg',
      },
      {
        'username': 'Ramadan Mabrouk',
        'rating': 4,
        'comment': 'الشقة مريحة جدا ونظيفة والموقع ممتاز وقريب من كل حاجة',
        'timeAgo': 'منذ أيام',
        'avatarUrl': 'assets/images/profile_pic.jpg',
      },
      {
        'username': 'Ahmed Mohamed',
        'rating': 5,
        'comment': 'موقع ممتاز وخدمة رائعة',
        'timeAgo': 'منذ 5 أيام',
        'avatarUrl': 'assets/images/profile_pic.jpg',
      },
      {
        'username': 'Sara Ali',
        'rating': 5,
        'comment': 'تجربة مميزة جداً',
        'timeAgo': 'منذ أسبوع',
        'avatarUrl': 'assets/images/profile_pic.jpg',
      },
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 0.3,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text(
                'آراء العملاء',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize * 1.2,
                  fontWeight: FontWeight.w300,
                  fontFamily: Fonts.primaryFontFamily,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReviewsScreen(),
                    ),
                  );
                },
                child: Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: const Color(0xff0F7757),
                    fontSize: fontSize * 0.9,
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: padding),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Container(
                  width: 320,
                  margin: const EdgeInsets.only(left: 12),
                  child: buildReviewCard(
                    name: review['username'],
                    rating: review['rating'].toDouble(),
                    comment: review['comment'],
                    imagePath: review['avatarUrl'],
                    timeAgo: review['timeAgo'],
                    fontSize: fontSize,
                    smallFontSize: smallFontSize,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReviewCard({
    required String name,
    required double rating,
    required String comment,
    required String imagePath,
    required String timeAgo,
    required double fontSize,
    required double smallFontSize,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 1,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(imagePath),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: fontSize * 0.95,
                        fontWeight: FontWeight.w200,
                        fontFamily: Fonts.primaryFontFamily,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: SvgPicture.asset(
                            index < rating 
                              ? "assets/icons/star.svg" 
                              : "assets/icons/starborder.svg",
                            width: 16,
                            height: 16,
                            color: const Color(0xff0F7757),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      comment,
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontFamily: Fonts.primaryFontFamily,
                        fontSize: fontSize * 0.85,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              timeAgo,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w100,
                fontSize: smallFontSize * 0.85,
                fontFamily: Fonts.primaryFontFamily
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}