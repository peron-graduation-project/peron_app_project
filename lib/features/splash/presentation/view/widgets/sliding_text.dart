import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context,_){
        return SlideTransition(
            position: slidingAnimation,
            child:  Text('بيرون',style: theme.titleSmall,textAlign: TextAlign.center,));
      },);
  }
}