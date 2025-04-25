import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final TextEditingController _commentController = TextEditingController();

  // قائمة لتخزين التقييمات
  final List<Map<String, dynamic>> _reviews = [
    {
      'username': 'Eid Said',
      'rating': 5,
      'comment': 'مكان هادي مناسب للعائلة',
      'timeAgo': 'منذ يومين',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'username': 'Ramadan Mabrouk',
      'rating': 4,
      'comment':
          'الشقة مريحة جدا ونظيفة والموقع ممتاز وقريب من كل حاجة. تجربة إيجار ممتازة!',
      'timeAgo': 'منذ أيام',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/41.jpg',
    },
    {
      'username': 'Eid Said',
      'rating': 5,
      'comment': 'مكان هادي مناسب للعائلة',
      'timeAgo': 'منذ 5 أيام',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'username': 'Ramadan Mabrouk',
      'rating': 4,
      'comment':
          'الشقة مريحة جدا ونظيفة والموقع ممتاز وقريب من كل حاجة. تجربة إيجار ممتازة!',
      'timeAgo': 'منذ أسبوع',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/41.jpg',
    },
  ];

  // دالة لإضافة تعليق جديد
  void _addNewComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _reviews.insert(0, {
          'username': 'أنت',
          'rating': 5, // افتراضي للمستخدم الحالي
          'comment': _commentController.text,
          'timeAgo': 'الآن',
          'avatarUrl':
              'https://randomuser.me/api/portraits/women/22.jpg', // صورة للمستخدم الحالي
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'التقييمات',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return _buildReviewCard(
                  username: review['username'],
                  rating: review['rating'],
                  comment: review['comment'],
                  timeAgo: review['timeAgo'],
                  avatarUrl: review['avatarUrl'],
                );
              },
            ),
          ),
          _buildCommentFooter(),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required String username,
    required int rating,
    required String comment,
    required String timeAgo,
    required String avatarUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 1,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المستخدم على اليمين
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
            radius: 16,
          ),
          const SizedBox(width: 10),
          // العمود الأيمن يحتوي الاسم والنجوم والتعليق
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // صف للاسم والتاريخ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // النجوم
                _buildRatingStars(rating),
                const SizedBox(height: 4),
                // التعليق
                Text(
                  comment,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: const Color(0xff0F7757), // لون أخضر
          size: 16,
        ),
      ),
    );
  }

  Widget _buildCommentFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const SizedBox(width: 12),

          // حقل كتابة التعليق
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _commentController,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'اكتب تعليق',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding: EdgeInsets.only(bottom: 10, right: 10),
                ),
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
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
