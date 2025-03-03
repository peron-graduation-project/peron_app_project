import 'package:flutter/material.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("الإشعارات", style: theme.headlineMedium!.copyWith(fontSize:20 )),
        centerTitle: true,
      ),
      body: NotificationBodyView(),
    );
  }
}
