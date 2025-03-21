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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                size: 22,
              ),
              const SizedBox(width: 10),

              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDeleteAccount == true ? Colors.red : Colors.black,
                ),
              ),

              const Spacer(),

              if (showArrow)
                const Icon(Icons.chevron_right, color: Colors.grey, size: 22),
              if (!showArrow) const SizedBox(width: 0), 
            ],
          ),
        ),
      ),
    );
  }
}