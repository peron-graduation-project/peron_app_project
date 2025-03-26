import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authentication/presentation/manager/logout/logout_cubit.dart';
import '../../../../authentication/presentation/manager/logout/logout_state.dart';

class LogoutButton extends StatelessWidget {
  final double screenWidth;

  const LogoutButton({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        } else if (state is LogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage),backgroundColor: Colors.red,),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state is LogoutLoading
              ? null
              : () {
            context.read<LogoutCubit>().logout();
          },
          icon: Icon(Icons.logout, color: Colors.white, size: screenWidth * 0.05),
          label: Text(
            "تسجيل الخروج",
            style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: Color(0xff0F7757),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
    );
  }
}
