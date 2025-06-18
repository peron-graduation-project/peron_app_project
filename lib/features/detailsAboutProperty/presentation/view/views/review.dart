import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/cubit/rate_cubit.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/cubit/rate_state.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/cubit/review_cubit.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/cubit/review_state.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate_param.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/ratingDialog.dart';
import 'package:peron_project/features/profile/presentation/manager/get%20profile/get_profile_cubit.dart';

class ReviewsScreen extends StatefulWidget {
  final int id;
  const ReviewsScreen({super.key, required this.id});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    print("hna in rates");

    super.initState();
  }

  // final List<Map<String, dynamic>> _reviews = [
  //   {
  //     'username': 'Eid Said',
  //     'rating': 5,
  //     'comment': 'مكان هادئ مناسب للعائلة',
  //     'timeAgo': 'منذ يومين',
  //     'avatarUrl': 'assets/images/profile_pic.jpg',
  //   },
  //   {
  //     'username': 'Ramadan Mabrouk',
  //     'rating': 4,
  //     'comment':
  //         'الشقة مريحة جدا ونظيفة والموقع ممتاز وقريب من كل حاجة. تجربة إيجار ممتازة!',
  //     'timeAgo': 'منذ أيام',
  //     'avatarUrl': 'assets/images/profile_pic.jpg',
  //   },
  //   {
  //     'username': 'Ahmed Mohamed',
  //     'rating': 5,
  //     'comment': 'موقع ممتاز وخدمة رائعة',
  //     'timeAgo': 'منذ 5 أيام',
  //     'avatarUrl': 'assets/images/profile_pic.jpg',
  //   },
  //   {
  //     'username': 'Sara Ali',
  //     'rating': 5,
  //     'comment': 'تجربة مميزة جداً',
  //     'timeAgo': 'منذ أسبوع',
  //     'avatarUrl': 'assets/images/profile_pic.jpg',
  //   },
  // ];

  void _addNewComment() {
    FocusScope.of(context).unfocus();
    if (_commentController.text.isNotEmpty) {
      context.read<RateCubit>().addRate(
        RateParam(
          stars: context.read<RateCubit>().getRate,
          comment: _commentController.text.trim(),
          propertyId: widget.id,
        ),
      );
      // setState(() {
      //   // _reviews.insert(0, {
      //   //   'username': 'أنت',
      //   //   'rating': 5,
      //   //   'comment': _commentController.text,
      //   //   'timeAgo': 'الآن',
      //   //   'avatarUrl': 'assets/images/profile_pic.jpg',
      //   // });
      //   _commentController.clear();
      // });
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
            fontFamily: Fonts.primaryFontFamily,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20,
            ),
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
            child: BlocConsumer<ReviewCubit, ReviewState>(
              listener: (context, state) {
                // if (state.status == ReviewStatus.added) {
                //   context.read<ReviewCubit>().getRates(widget.id);
                // }
              },
              builder: (context, state) {
                if (state.status == ReviewStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.status == ReviewStatus.failure) {
                  return Text(
                    '${state.errorMessage}',
                    style: TextStyle(
                      color: const Color(0xff0F7757),
                      fontSize: fontSize * 0.9,
                      fontFamily: Fonts.primaryFontFamily,
                    ),
                  );
                } else if (state.status == ReviewStatus.success) {
                  if (state.rates.isEmpty) {
                    return Center(
                      child: Text(
                        "لا يوجد آراء بعد",
                        style: TextStyle(
                          color: const Color(0xff0F7757),
                          fontSize: fontSize * 0.9,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(padding),
                      itemCount: state.rates.length,
                      itemBuilder: (context, index) {
                        print("hna name build ${state.rates[index].userName}");
                        // final review = state.rates[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildReviewCard(
                            name: state.rates[index].userName,
                            rating: state.rates[index].stars ?? 0,
                            comment: state.rates[index].comment,
                            imagePath: 'assets/images/profile_pic.jpg',
                            timeAgo: state.rates[index].createdAt,
                            fontSize: fontSize,
                            smallFontSize: smallFontSize,
                            ratId: state.rates[index].ratingId,
                          ),
                        );
                      },
                    );
                  }
                }
                return SizedBox();
              },
            ),
          ),
          _buildCommentFooter(),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required String name,
    required int rating,
    required int ratId,
    required String comment,
    required String imagePath,
    required String timeAgo,
    required double fontSize,
    required double smallFontSize,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade200, width: 1.0),
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
              Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: Fonts.primaryFontFamily,
                            color: Colors.black,
                          ),
                        ),
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
                        const SizedBox(height: 8),
                        Text(
                          comment,
                          style: TextStyle(
                            fontFamily: Fonts.primaryFontFamily,
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
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        if (name == context.read<GetProfileCubit>().getName)
          Positioned(
            top: 8,
            left: 8,
            child: BlocConsumer<RateCubit, RateState>(
              listener: (context, state) {
                if (state.status == RateStatus.deletedRate &&
                    name == context.read<GetProfileCubit>().getName) {
                  context.read<RateCubit>().resetRate();
                  context.read<ReviewCubit>().getRates(widget.id);
                } else if (state.status == RateStatus.failure &&
                    name == context.read<GetProfileCubit>().getName) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${state.errorMessage}')),
                  );
                }
              },
              builder: (context, state) {
                if (state.status == RateStatus.deleteRate &&
                    name == context.read<GetProfileCubit>().getName) {
                  return CircularProgressIndicator();
                }
                return IconButton(
                  onPressed:
                      (name == context.read<GetProfileCubit>().getName)
                          ? () => context.read<RateCubit>().deleteRate(ratId)
                          : null,
                  icon: Icon(Icons.delete, color: Colors.red),
                );
              },
            ),
          ),
      ],
    );
  }

  // تعديل تصميم مربع التعليق ليتناسب مع التصميم الجديد
  Widget _buildCommentFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
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
                onChanged: (value) => setState(() {}),
                controller: _commentController,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'اكتب تعليق',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color:
                  _commentController.text.isEmpty
                      ? Colors.grey
                      : Color(0xff0F7757),
              shape: BoxShape.circle,
            ),
            child: BlocConsumer<RateCubit, RateState>(
              listener: (context, state) {
                if (state.status == RateStatus.addedRate) {
                  _commentController.clear();
                  context.read<ReviewCubit>().getRates(widget.id);
                } else if (state.status == RateStatus.failure) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('${state.errorMessage}')),
                  // );
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed:
                      (state.status == RateStatus.addRate)
                          ? null
                          : _commentController.text.isEmpty
                          ? null
                          : (context.read<RateCubit>().getRate == 0)
                          ? () => showDialog(
                            builder: (context) => RatingDialog(),
                            context: context,
                          )
                          : _addNewComment,
                  icon: const Icon(Icons.send, color: Colors.white, size: 22),
                  padding: EdgeInsets.zero,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
