import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool showArrow;
  final bool? isDeleteAccount;
  final VoidCallback onTap;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon, 
    required this.showArrow,
    required this.onTap,
    this.isDeleteAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.012),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, 
            vertical: size.height * 0.018
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDeleteAccount == true
                    ? Colors.red
                    : const Color(0xFF666666),
                size: isSmallScreen ? 18 : 22,
              ),
              SizedBox(width: size.width * 0.025),

              Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: isDeleteAccount == true ? Colors.red : Colors.black,
                ),
              ),

              const Spacer(),

              if (showArrow)
                Icon(
                  Icons.chevron_right, 
                  color: Colors.grey, 
                  size: isSmallScreen ? 18 : 22
                ),
              if (!showArrow) const SizedBox(width: 0), 
            ],
          ),
        ),
      ),
    );
  }
}
