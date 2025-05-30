import 'package:flutter/material.dart';

class RecommendedPropertyInfoDetails extends StatelessWidget {
  final IconData icon;
  final String title;
  final String label;
  final Color iconColor;

  const RecommendedPropertyInfoDetails({
    super.key,
    required this.icon,
    required this.title,
    required this.label,
    this.iconColor = const Color(0xff818181),
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor,size: 18,),
        const SizedBox(width: 4),
        Text(
          '$title:',
          style: theme.bodySmall?.copyWith(color: const Color(0xffBABABA)),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            style: theme.bodySmall?.copyWith(color: const Color(0xff282929)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
