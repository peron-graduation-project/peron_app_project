import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final TextEditingController _commentController = TextEditingController();

  final List<Map<String, dynamic>> _reviews = [
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
      'comment':
          'الشقة مريحة جدا ونظيفة والموقع ممتاز وقريب من كل حاجة. تجربة إيجار ممتازة!',
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
  ];

  // إضافة تعليق جديد
  void _addNewComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _reviews.insert(0, {
          'username': 'أنت',
          'rating': 5,
          'comment': _commentController.text,
          'timeAgo': 'الآن',
          'avatarUrl': 'assets/images/profile_pic.jpg',
        });
        _commentController.clear();
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = 16.0;
    final double fontSize = 14.0;
    final double smallFontSize = 12.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'التقييمات',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: Fonts.primaryFontFamily
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios,
                color: Colors.black, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(padding),
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildReviewCard(
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
          _buildCommentFooter(),
        ],
      ),
    );
  }

  // تصميم بطاقة التقييم مستوحى من ReviewsSection
  Widget _buildReviewCard({
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الصف العلوي مع صورة الملف الشخصي والاسم جنبًا إلى جنب
          Row(
            textDirection: TextDirection.rtl, // إجبار اتجاه RTL
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الملف الشخصي - على أقصى اليمين
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(imagePath),
              ),
              const SizedBox(width: 10),
              // عمود الاسم والمحتوى
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // في وضع RTL، هذا يحاذي إلى اليمين
                  children: [
                    // الاسم
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.primaryFontFamily,

                        color: Colors.black,
                      ),
                    ),
                    // تقييم النجوم - مباشرة تحت الاسم
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: const Color(0xff0F7757),
                          size: 18,
                        ),
                      ),
                    ),
                    // نص التعليق - تحت النجوم
                    const SizedBox(height: 8),
                    Text(
                      comment,
                      style: TextStyle(
                                    fontFamily: Fonts.primaryFontFamily
,
                        fontSize: fontSize * 0.9,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // مساحة لدفع الوقت إلى الأسفل
          const SizedBox(height: 12),
          // نص الوقت - محاذاة إلى اليسار
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              timeAgo,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: smallFontSize * 0.9,
                            fontFamily: Fonts.primaryFontFamily

              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  // تعديل تصميم مربع التعليق ليتناسب مع التصميم الجديد
  Widget _buildCommentFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // حقل كتابة التعليق
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _commentController,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'اكتب تعليق',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14,            fontFamily: Fonts.primaryFontFamily
),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xff0F7757),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _addNewComment,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 22,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
